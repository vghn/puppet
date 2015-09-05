#!/usr/bin/env bash
#
# If a $PRIVATE_DATA variable exists (ex: s3://myBucket), it will download the
# contents prefixed by the environment name into the local enviroment folder.
# Ex: `$PRIVATE_DATA='s3://myBucket'` will download the contents of
#     `s3://myBucket/production` into `/etc/puppetlabs/code/environments/production`

ROLE=$(facter role)
ENVIRONMENTPATH=$(puppet config print environmentpath)
S3_PATH='s3://vladgh/hiera'

if [ ! -z "$AWS_REGION" ]; then
  AWS_ZONE=$(wget --timeout=3 -qO- 'http://instance-data/latest/meta-data/placement/availability-zone')
  AWS_REGION="${AWS_ZONE%?}"
  AWS_REGION="${AWS_REGION:-us-east-1}"
fi

for dir in ${ENVIRONMENTPATH}/*; do
  [[ -d $dir ]] || break
  environment=$(basename "$dir")
  /usr/local/bin/aws --region "$AWS_REGION" s3 cp \
    "${S3_PATH}/${environment}/${ROLE}.yaml" "${dir}/data/${ROLE.yaml}" || break
done
