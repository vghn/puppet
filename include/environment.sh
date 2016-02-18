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

# Version
export VERSION; VERSION="$(cat "${APPDIR}/VERSION")"

# Git
export BRANCH; BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || true)
case "${BRANCH}" in
  master)
    export ENV_TYPE='production'
    ;;
  '')
    if [[ -n "$TRAVIS_BRANCH" ]]; then
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

# CI
export CI=${CI:-false}
export PR=${TRAVIS_PULL_REQUEST:-false}
export BUILD=${TRAVIS_BUILD_NUMBER:-0}
if [[ ${CI} == true ]]; then
  export AWS_ACCESS_KEY_ID=$CI_AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$CI_AWS_SECRET_ACCESS_KEY

  git config --global user.name "TravisCI"
fi

# AWS S3
export AWS_ASSETS_BUCKET="$VGH_ASSETS_BUCKET"
export AWS_ASSETS_KEY_PREFIX="puppet/${ENV_TYPE}"

# AWS CodeDeploy
export CD_APP_NAME="$VGH_APPLICATION_NAME"
export CD_BUNDLE_TYPE='tgz'
export CD_ARCHIVE="${CD_APP_NAME}-${VERSION}-${BUILD}.${CD_BUNDLE_TYPE}"
export CD_ARCHIVE_PATH="/tmp/${CD_ARCHIVE}"
export CD_GROUP_NAME="${ENV_TYPE}"
export CD_CONFIG='CodeDeployDefault.OneAtATime'
export CD_BUCKET="$AWS_ASSETS_BUCKET"
export CD_KEY_PREFIX="${AWS_ASSETS_KEY_PREFIX}/deploy"
export CD_KEY="${CD_KEY_PREFIX}/${CD_ARCHIVE}"
export CD_S3_PATH="s3://${CD_BUCKET}/${CD_KEY}"

# AWS CloudFormation
export CFN_STACK_NAME="$VGH_STACK_NAME"
export CFN_STACK_TEMPLATE="file://${APPDIR}/${VGH_STACK_FILE}"
export CFN_STACK_S3="s3://${AWS_ASSETS_BUCKET}/${AWS_ASSETS_KEY_PREFIX}/cfn"
export CFN_STACK_URL="https://s3.amazonaws.com/${AWS_ASSETS_BUCKET}/${AWS_ASSETS_KEY_PREFIX}/cfn"
export CFN_STACK_CAPABILITIES='CAPABILITY_IAM'
export CFN_STACK_ON_FAILURE='DELETE'

export CFN_STACK_PARAMETERS; CFN_STACK_PARAMETERS=$(cat <<CFPARAMS
[
  { "ParameterKey": "KeyName", "ParameterValue": "${VGH_EC2_KEY}" },
  { "ParameterKey": "AssetsBucket", "ParameterValue": "${AWS_ASSETS_BUCKET}" },
  { "ParameterKey": "EnvType", "ParameterValue": "${ENV_TYPE}" },
  { "ParameterKey": "SSHLocation", "ParameterValue": "${EXTERNAL_IP}/32" },
  { "ParameterKey": "VPCTemplateKey", "ParameterValue": "${CFN_STACK_URL}/vpc.json" },
  { "ParameterKey": "SGTemplateKey", "ParameterValue": "${CFN_STACK_URL}/sg.json" },
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

# Puppet
export SSLDIR="${APPDIR}/ssl_ca"
export CRTDIR="${APPDIR}/ssl_certs"

