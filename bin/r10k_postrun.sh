#!/usr/bin/env bash
#
# Download the private role file from S3 (if permitted). It will fail silently.
#
# Ex.:
# s3://mybucket/data/production/myrole.yaml =>
# /etc/puppetlabs/code/environments/production/data/myrole.yaml

# DEFAULTS
S3_PATH='s3://vladgh/data'

# VARs
ROLE=$(/opt/puppetlabs/bin/facter role)
ENVIRONMENTPATH=$(/opt/puppetlabs/bin/puppet config print environmentpath)
REGION=$(/opt/puppetlabs/bin/facter ec2_region)

# Download file
for envdir in ${ENVIRONMENTPATH}/*; do
  [[ -d $envdir ]] || break
  env=$(basename "$envdir")
  /usr/local/bin/aws --region "$REGION" s3 cp \
    "${S3_PATH}/${env}/${ROLE}.yaml" \
    "${envdir}/data/${ROLE}.private.yaml" || break
done
