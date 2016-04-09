#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Paths
export APPDIR TMPDIR PATH
APPDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmp')
PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:/usr/local/bin:${PATH}"

# Load VGS Library
# shellcheck disable=1090,1091
if [[ -s /opt/vgs/load ]]; then
  . /opt/vgs/load
elif [[ -s "${HOME}/vgs/load" ]]; then
  . "${HOME}/vgs/load"
fi

# Load AWS environment
# shellcheck disable=SC1091
[[ -s /var/lib/cloud/instance/.env ]] && . /var/lib/cloud/instance/.env

# Load private environment
# shellcheck disable=SC1090
[[ -s "${APPDIR}/.env" ]] && . "${APPDIR}/.env"

# Project
export PROJECT_NAME="${PROJECT_NAME:-$(basename "${APPDIR}")}"
export PROJECT_PATH="${PROJECT_PATH:-/opt/${PROJECT_NAME}}"

# Version
export VERSION_FILE="${APPDIR}/VERSION"
export CHANGELOG_FILE="${APPDIR}/CHANGELOG.md"
export VERSION; VERSION=$(cat "$VERSION_FILE")

# Detect environment
GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo '')
TRAVIS_BRANCH="${TRAVIS_BRANCH:-}"
DEPLOYMENT_GROUP_NAME="${DEPLOYMENT_GROUP_NAME:-}"

## Detect if git directory or if Travis CI or if AWS CodeDeploy
if [[ -n "${ENVTYPE:-}" ]]; then
  ENVTYPE="$ENVTYPE"
elif [[ -n "${GIT_BRANCH:-}" ]]; then
  ENVTYPE="$GIT_BRANCH"
elif [[ -n "${TRAVIS_BRANCH:-}" ]]; then
  ENVTYPE="$TRAVIS_BRANCH"
elif [[ -n "${CIRCLE_BRANCH:-}" ]]; then
  ENVTYPE="$CIRCLE_BRANCH"
elif [[ -n "${DEPLOYMENT_GROUP_NAME:-}" ]]; then
  ENVTYPE="$DEPLOYMENT_GROUP_NAME"
else
  ENVTYPE=${ENVTYPE:-development}
fi

## Rename 'master' to 'production'
if [[ "$ENVTYPE" == 'master' ]]; then
  export ENVTYPE='production'
fi

# CI
export CI=${CI:-false}
export PR=false
if [[ ${CIRCLECI:-false} == true ]]; then
  export PR=${CIRCLE_PR_NUMBER:-false}
  export BUILD=${CIRCLE_BUILD_NUM:-0}
  git config --global user.name "CircleCI"
elif [[ ${TRAVIS:-false} == true ]]; then
  export PR=${TRAVIS_PULL_REQUEST:-false}
  export BUILD=${TRAVIS_BUILD_NUMBER:-0}
  git config --global user.name "TravisCI"
fi

# Trusted IPs
export TRUSTED_IPS="${TRUSTED_IPS:-"$(vgs_get_external_ip)/32"}"

# Slack Incoming Web Hook URL
export SLACK_CHANNEL="${SLACK_CHANNEL:-general}"
export SLACK_USER="${SLACK_USER:-Bot}"
export SLACK_WEBHOOK="${SLACK_WEBHOOK:-'https://hooks.slack.com/services/ChangeMe'}"

# AWS
export AWS_ACCOUNT_NUMBER="${AWS_ACCOUNT_NUMBER:-}"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"

# AWS S3
export AWS_ASSETS_BUCKET="${AWS_ASSETS_BUCKET:-$PROJECT_NAME}"
export AWS_ASSETS_KEY_PREFIX="$ENVTYPE"
export AWS_ASSETS_S3_PATH="s3://${AWS_ASSETS_BUCKET}/${AWS_ASSETS_KEY_PREFIX}"

# AWS EC2
export AWS_EC2_KEY="${AWS_EC2_KEY:-key}"
export AWS_EC2_IMAGE_PREFIX="${AWS_EC2_IMAGE_PREFIX:-AMI}"
export AWS_EC2_IMAGE_DESCRIPTION="${AWS_EC2_IMAGE_DESCRIPTION:-AMI}"
export AWS_EC2_INSTANCE_TYPE="${AWS_EC2_INSTANCE_TYPE:-t2.micro}"

# AWS TAGs
export AWS_TAG_GROUP="${AWS_TAG_GROUP:MyGroup}"

# AWS RDS
export AWS_RDS_DB_ENGINE="${AWS_RDS_DB_ENGINE:-MySQL}"
export AWS_RDS_DB_NAME="${AWS_RDS_DB_NAME:-db}"
export AWS_RDS_DB_USER="${AWS_RDS_DB_USER:-admin}"
export AWS_RDS_DB_PASS="${AWS_RDS_DB_PASS:-ChangeMe}"

# AWS SNS
export AWS_SNS_NOTIFICATIONS="${AWS_SNS_NOTIFICATIONS:-"arn:aws:sns:${AWS_DEFAULT_REGION}:${AWS_ACCOUNT_NUMBER}:NotifyMe"}"

# AWS SSL
export AWS_SSL_ARN="${AWS_SSL_ARN:-}"

# CloudFormation
export CFN_STACKS_PATH="${APPDIR}/cfn"
export CFN_STACKS_S3_PATH="${AWS_ASSETS_S3_PATH}/cfn"
export CFN_STACK_NAME='VGH'
export CFN_STACK_BODY="${CFN_STACKS_PATH}/${CFN_STACK_NAME}.json"
export CFN_CMD_ARGS="--stack-name ${CFN_STACK_NAME} --template-body file://${CFN_STACK_BODY}"
process_cfn_stacks(){
  local stack action
  stack=${1:-}
  action=${2:-}
  local ARGS P T

  case "$stack" in
    vgh)
      export CFN_STACK_NAME='VGH'
      export CFN_STACK_BODY="${CFN_STACKS_PATH}/vgh.json"
      if [[ "$action" == 'create' ]]; then
        ARGS='--disable-rollback --capabilities CAPABILITY_IAM'
      elif [[ "$action" == 'update' ]]; then
        ARGS='--capabilities CAPABILITY_IAM'
      else
        ARGS=''
      fi
      P="   ParameterKey=Version,ParameterValue=${VERSION}"
      P="$P ParameterKey=EnvType,ParameterValue=${ENVTYPE}"
      P="$P ParameterKey=KeyName,ParameterValue=${AWS_EC2_KEY}"
      P="$P ParameterKey=AssetsBucket,ParameterValue=${AWS_ASSETS_BUCKET}"
      P="$P ParameterKey=AMIPrefix,ParameterValue=${AWS_IMAGE_PREFIX}_*"
      P="$P 'ParameterKey=SSHLocations,ParameterValue=\"${TRUSTED_IPS}\"'"
      P="$P ParameterKey=DBEngine,ParameterValue=${AWS_RDS_DB_ENGINE}"
      P="$P ParameterKey=DBName,ParameterValue=${AWS_RDS_DB_NAME}"
      P="$P ParameterKey=DBUser,ParameterValue=${AWS_RDS_DB_USER}"
      P="$P ParameterKey=DBPassword,ParameterValue=${AWS_RDS_DB_PASS}"
      P="$P ParameterKey=SSLCertificateId,ParameterValue=${AWS_SSL_ARN}"
      P="$P ParameterKey=VPCTemplateKey,ParameterValue=vpc.json"
      P="$P ParameterKey=SGTemplateKey,ParameterValue=sg.json"
      P="$P ParameterKey=IAMTemplateKey,ParameterValue=iam.json"
      P="$P ParameterKey=RDSTemplateKey,ParameterValue=rds.json"
      T="   Key=Group,Value=${AWS_TAG_GROUP}"
      export CFN_CMD_ARGS="--stack-name ${CFN_STACK_NAME} --template-body file://${CFN_STACK_BODY} ${ARGS} --parameters ${P} --tags ${T}"
      ;;
    ci)
      export CFN_STACK_NAME='CI'
      export CFN_STACK_BODY="${CFN_STACKS_PATH}/ci.json"
      if [[ "$action" == 'create' ]]; then
        ARGS='--disable-rollback --capabilities CAPABILITY_IAM'
      elif [[ "$action" == 'update' ]]; then
        ARGS='--capabilities CAPABILITY_IAM'
      else
        ARGS=''
      fi
      T="Key=Group,Value=${AWS_TAG_GROUP}"
      export CFN_CMD_ARGS="--stack-name ${CFN_STACK_NAME} --template-body file://${CFN_STACK_BODY} ${ARGS} --tags ${T}"
      ;;
    *)
      ;;
  esac
}

# AWS CodeDeploy
export AWS_CD_APP_NAME="$PROJECT_NAME"
export AWS_CD_BUCKET="$AWS_ASSETS_BUCKET"
export AWS_CD_BUNDLE_TYPE='tgz'
export AWS_CD_ARCHIVE="${AWS_CD_APP_NAME}-${VERSION}-${BUILD:-0}.${AWS_CD_BUNDLE_TYPE}"
export AWS_CD_S3_KEY_PREFIX="${AWS_ASSETS_KEY_PREFIX}/deploy"
export AWS_CD_S3_KEY="${AWS_CD_S3_KEY_PREFIX}/${AWS_CD_ARCHIVE}"
export AWS_CD_S3_PATH="s3://${AWS_CD_BUCKET}/${AWS_CD_S3_KEY}"
export AWS_CD_S3_PATH_LATEST="s3://${AWS_CD_BUCKET}/${AWS_CD_S3_KEY_PREFIX}/latest.tgz"
export AWS_CD_ARCHIVE_PATH="${TMPDIR}/${AWS_CD_ARCHIVE}"
export AWS_CD_GROUP_NAME="${ENVTYPE}"
export AWS_CD_CONFIG='CodeDeployDefault.OneAtATime'

# AWS Lambda
export AWS_LAMBDAS_PATH="${APPDIR}/lambdas"
export AWS_LAMBDAS_S3_PATH="${AWS_ASSETS_S3_PATH}/lambdas"
