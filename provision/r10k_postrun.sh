#!/usr/bin/env bash
#
# If a $PRIVATE_DATA variable exists (ex: s3://myBucket), it will download the
# contents prefixed by the environment name into the local enviroment folder.
# Ex: `$PRIVATE_DATA='s3://myBucket'` will download the contents of
#     `s3://myBucket/production` into `/etc/puppetlabs/code/environments/production`

ENV_DIR='/etc/puppetlabs/code/environments'

if [ ! -z "$AWS_REGION" ]; then
  AWS_ZONE=$(wget --timeout=3 -qO- 'http://instance-data/latest/meta-data/placement/availability-zone')
  AWS_REGION="${AWS_ZONE%?}"
  AWS_REGION="${AWS_REGION:-us-east-1}"
fi

if [[ "${PRIVATE_DATA}" =~ ^s3:// ]]; then
  for dir in ${ENV_DIR}/*; do
    [[ -d $dir ]] || break
    name=$(basename "$dir")
    priv="${dir}/hieradata/private"
    mkdir -p "$priv"
    /usr/local/bin/aws --region "$AWS_REGION" s3 sync \
      "${PRIVATE_DATA}/${name}/" "${priv}/" --delete || break
  done
  #find ${ENV_DIR} -type d -empty -delete
fi
