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
external_ip=$(dig +short myip.opendns.com @resolver1.opendns.com || true)

# AWS
export AWS_DEFAULT_REGION='us-east-1'

## CloudFormation
export vgh_stack_name=${vgh_stack_name:-vgh}
export vgh_stack_file=${vgh_stack_file:-file://./cfn/vgh.json}
export vgh_env_type=${vgh_env_type:-$ENV_TYPE}
export vgh_ec2_key=${vgh_ec2_key:-key}
export vgh_ssh_location="${external_ip}/32"
export vgh_stack_capabilities=${vgh_stack_capabilities:-CAPABILITY_IAM}
export vgh_notifications_topic_arn=${vgh_notifications_topic_arn:-arn:aws:sns:us-east-1:12345:Topic}

export vgh_assets_bucket=${vgh_assets_bucket:-vladgh}
export vgh_assets_key_prefix=${vgh_assets_key_prefix:-puppet}
export vgh_assets_s3path="${vgh_assets_bucket}/${vgh_assets_key_prefix}/${ENV_TYPE}"

export vgh_cfn_stack_s3="s3://${vgh_assets_s3path}/cfn"
export vgh_cfn_stack_url="https://s3.amazonaws.com/${vgh_assets_s3path}/cfn"

export vgh_stack_parameters="\
  ParameterKey=KeyName,ParameterValue=${vgh_ec2_key} \
  ParameterKey=AssetsBucket,ParameterValue=${vgh_assets_bucket} \
  ParameterKey=EnvType,ParameterValue=${vgh_env_type} \
  ParameterKey=SSHLocation,ParameterValue=${vgh_ssh_location} \
  ParameterKey=VPCTemplateKey,ParameterValue=${vgh_cfn_stack_url}/vpc.json \
  ParameterKey=SGTemplateKey,ParameterValue=${vgh_cfn_stack_url}/iam.json \
  ParameterKey=IAMTemplateKey,ParameterValue=${vgh_cfn_stack_url}/sec_grp.json"

export vgh_group_tag=${vgh_group_tag:-vgh}
export vgh_stack_tags="\
  Key=Group,Value=${vgh_group_tag}"
