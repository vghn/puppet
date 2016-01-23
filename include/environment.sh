#!/usr/bin/env bash
# Paths
export APPDIR PATH
APPDIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd -P)/.."
PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:/usr/local/bin:${PATH}"

# Load global environment
# shellcheck disable=SC1090,SC1091
. "${APPDIR}/defaults.env" || true

# Load private environment
# shellcheck disable=SC1090,SC1091
. "${APPDIR}/.env" || true

# Git
export BRANCH; BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)
case "${BRANCH}" in
  master)
    export ENV_TYPE='production'
    ;;
  '')
    export BRANCH=$TRAVIS_BRANCH
    export ENV_TYPE="$BRANCH"
    ;;
  *)
    export ENV_TYPE="$BRANCH"
    ;;
esac

# External ip
export external_ip
external_ip=$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null \
  || true)

# AWS Credentials
if [[ "${CI:-false}" == true ]]; then
  export AWS_ACCESS_KEY_ID=$CI_AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$CI_AWS_SECRET_ACCESS_KEY
fi

# CloudFormation
export vgh_stack_capabilities=${vgh_stack_capabilities:-CAPABILITY_IAM}
export vgh_assets_s3path="${VGH_ASSETS_BUCKET}/puppet/${ENV_TYPE}"
export vgh_cfn_stack_s3="s3://${vgh_assets_s3path}/cfn"
export vgh_cfn_stack_url="https://s3.amazonaws.com/${vgh_assets_s3path}/cfn"

export vgh_stack_parameters; vgh_stack_parameters=$(cat <<CFPARAMS
[
  { "ParameterKey": "KeyName", "ParameterValue": "${VGH_EC2_KEY}" },
  { "ParameterKey": "AssetsBucket", "ParameterValue": "${VGH_ASSETS_BUCKET}" },
  { "ParameterKey": "EnvType", "ParameterValue": "${ENV_TYPE}" },
  { "ParameterKey": "SSHLocation", "ParameterValue": "${external_ip}/33" },
  { "ParameterKey": "VPCTemplateKey", "ParameterValue": "${vgh_cfn_stack_url}/vpc.json" },
  { "ParameterKey": "SGTemplateKey", "ParameterValue": "${vgh_cfn_stack_url}/sec_grp.json" },
  { "ParameterKey": "IAMTemplateKey", "ParameterValue": "${vgh_cfn_stack_url}/iam.json" }
]
CFPARAMS
)

export vgh_stack_tags; vgh_stack_tags=$(cat <<CFTAGS
[
  { "Key": "Group", "Value": "${VGH_GROUP}" }
]
CFTAGS
)

