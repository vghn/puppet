#!/usr/bin/env bash
# **All variables declared here are public**. Any sensitive information should
# be placed in an `.env` file which will overwrite the information here.

# VARs

## Paths
export PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:/usr/local/bin:${PATH}"
export REPODIR=${REPODIR:-$(git rev-parse --show-toplevel)}

## Git
export BRANCH; BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "$TRAVIS_BRANCH")

case "${BRANCH}" in
  master)
    export ENV_TYPE='production'
    ;;
  *)
    export ENV_TYPE="$BRANCH"
    ;;
esac

## External ip
external_ip=$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || true)

# AWS
export AWS_DEFAULT_REGION='us-east-1'

## CloudFormation
export vgh_stack_name=${vgh_stack_name:-vgh}
export vgh_stack_file=${vgh_stack_file:-file://./cfn/vgh.json}
export vgh_env_type=${vgh_env_type:-$ENV_TYPE}
export vgh_ec2_key=${vgh_ec2_key:-key}
export vgh_ssh_location="${external_ip}/32"
export vgh_stack_capabilities=${vgh_stack_capabilities:-CAPABILITY_IAM}

export vgh_assets_bucket=${vgh_assets_bucket:-vladgh}
export vgh_assets_key_prefix=${vgh_assets_key_prefix:-puppet}
export vgh_assets_s3path="${vgh_assets_bucket}/${vgh_assets_key_prefix}/${ENV_TYPE}"

export vgh_cfn_stack_s3="s3://${vgh_assets_s3path}/cfn"
export vgh_cfn_stack_url="https://s3.amazonaws.com/${vgh_assets_s3path}/cfn"

export vgh_stack_parameters; vgh_stack_parameters=$(cat <<CFPARAMS
[
  { "ParameterKey": "KeyName", "ParameterValue": "${vgh_ec2_key}" },
  { "ParameterKey": "AssetsBucket", "ParameterValue": "${vgh_assets_bucket}" },
  { "ParameterKey": "EnvType", "ParameterValue": "${vgh_env_type}" },
  { "ParameterKey": "SSHLocation", "ParameterValue": "${vgh_ssh_location}" },
  { "ParameterKey": "VPCTemplateKey", "ParameterValue": "${vgh_cfn_stack_url}/vpc.json" },
  { "ParameterKey": "SGTemplateKey", "ParameterValue": "${vgh_cfn_stack_url}/sec_grp.json" },
  { "ParameterKey": "IAMTemplateKey", "ParameterValue": "${vgh_cfn_stack_url}/iam.json" }
]
CFPARAMS
)

export vgh_group_tag=${vgh_group_tag:-vgh}
export vgh_stack_tags; vgh_stack_tags=$(cat <<CFTAGS
[
  { "Key": "Group", "Value": "${vgh_group_tag}" }
]
CFTAGS
)

## AMI
export vgh_image_key='vgh'
export vgh_image_user_data="${REPODIR}/include/user_data_image.sh"
export vgh_image_instance_type='t2.micro'
export vgh_image_os='trusty'
vgh_image_prefix='VGH_HERA'
vgh_image_suffix=$(date +%Y%m%d%H%M%S)
export vgh_image_name="${vgh_image_prefix}_${vgh_image_suffix}"
export vgh_image_description='VGH Image - HERA'
export vgh_image_arch='amd64'
export vgh_image_virtualization='hvm'
