#!/usr/bin/env bash
# Creates CloudFormation stack

# Load environment
# shellcheck disable=1090
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/../include/common.sh"

case "$1" in
  install)
    pip install --user awscli
    cd dist/profile || exit
    bundle install --without development system_tests --path vendor
    ;;
  script)
    cd dist/profile || exit
    bundle exec rake test
    ;;
  deploy)
    if aws s3 sync "${REPODIR}/cfn/" "${vgh_cfn_stack_s3:?}/" \
      --delete --acl public-read \
      --exclude "*" --include "*.json"; then
        echo "Synced ${REPODIR}/cfn/ to ${vgh_cfn_stack_s3}"
    else
      echo "FATAL: Could not sync ${REPODIR}/cfn/ to ${vgh_cfn_stack_s3}"
      exit 1
    fi
    ;;
esac

