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
export BRANCH; BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || true)
case "${BRANCH}" in
  master)
    export ENV_TYPE='production'
    ;;
  '')
    if [[ -z "$TRAVIS_BRANCH" ]]; then
      export BRANCH="$TRAVIS_BRANCH"
    else
      export BRANCH='development'
    fi
    export ENV_TYPE="$BRANCH"
    ;;
  *)
    export ENV_TYPE="$BRANCH"
    ;;
esac

# External ip
export EXTERNAL_IP
EXTERNAL_IP=$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null \
  || true)

# AWS
if [[ "${CI:-false}" == true ]]; then
  export AWS_ACCESS_KEY_ID=$CI_AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$CI_AWS_SECRET_ACCESS_KEY
fi
export AWS_ASSETS_S3_PREFIX="${VGH_ASSETS_BUCKET}/puppet/${ENV_TYPE}"

# CloudFormation
export CFN_STACK_NAME="$VGH_STACK_NAME"
export CFN_STACK_TEMPLATE="file://${APPDIR}/${VGH_STACK_FILE}"
export CFN_STACK_S3="s3://${AWS_ASSETS_S3_PREFIX}/cfn"
export CFN_STACK_URL="https://s3.amazonaws.com/${AWS_ASSETS_S3_PREFIX}/cfn"
export CFN_STACK_CAPABILITIES='CAPABILITY_IAM'
export CFN_STACK_ON_FAILURE='DELETE'

export CFN_STACK_PARAMETERS; CFN_STACK_PARAMETERS=$(cat <<CFPARAMS
[
  { "ParameterKey": "KeyName", "ParameterValue": "${VGH_EC2_KEY}" },
  { "ParameterKey": "AssetsBucket", "ParameterValue": "${VGH_ASSETS_BUCKET}" },
  { "ParameterKey": "EnvType", "ParameterValue": "${ENV_TYPE}" },
  { "ParameterKey": "SSHLocation", "ParameterValue": "${EXTERNAL_IP}/32" },
  { "ParameterKey": "VPCTemplateKey", "ParameterValue": "${CFN_STACK_URL}/vpc.json" },
  { "ParameterKey": "SGTemplateKey", "ParameterValue": "${CFN_STACK_URL}/sec_grp.json" },
  { "ParameterKey": "IAMTemplateKey", "ParameterValue": "${CFN_STACK_URL}/iam.json" }
]
CFPARAMS
)

export CFN_STACK_TAGS; CFN_STACK_TAGS=$(cat <<CFTAGS
[
  { "Key": "Group", "Value": "${VGH_GROUP}" }
]
CFTAGS
)

