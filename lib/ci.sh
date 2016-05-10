#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Ensure latest Python PIP and AWS-CLI'
  pip install --user --upgrade pip awscli

  echo 'Sync hiera data'
  aws s3 sync --delete "$PP_HIERA_S3_PATH" "${APPDIR}/hieradata" || true

  cd "${APPDIR}/dist/profile" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
  e_info 'Install required testing gems'
  bundle install --without development system_tests --path vendor

  e_info 'Install required puppet module'
  bundle exec rake spec_prep
}

# CI Test
ci_test(){
  bash -c "${APPDIR}/bin/cfn validate"

  e_info 'Running tests'
  cd "${APPDIR}/dist/profile" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
  bundle exec rake test
}

# EC2 Run Command
send_ec2_run_command(){
  local role
  role=${1:?}

  e_info "Looking for instances tagged ${role}"
  ids=$(aws ec2 describe-instances \
    --filter Name=tag:Role,Values="$role" Name=instance-state-name,Values=running \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text)
  if [[ -n "$ids" ]]; then
    e_info "Found ids: ${ids}, for group ${role}"
  else
    e_warn 'Did not find any instances!'; return
  fi

  e_info "Sending ec2 run command"
  # shellcheck disable=2086
  command_id=$(aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --instance-ids $ids \
    --parameters $'{"commands":["sudo /opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose"]}' \
    --comment "Deploy R10K environment" \
    --timeout-seconds 600 \
    --query 'Command.CommandId' \
    --output text)

  if [[ -n "$command_id" ]]; then
    e_info "Wait for command (id: $command_id)"
    status=
    until [[ "$status" =~ ^(Success|Failed|Timed Out|Cancelled)$ ]]; do
      status="$(aws ssm list-commands --command-id "$command_id" --query 'Commands[].Status' --output text)"
      sleep 1
    done
    e_info "Command returned '${status}'"
  else
    e_abort 'Could not send command'
  fi
}

# CI Deploy
ci_deploy(){
  if [[ "$PR" == false ]]; then
    bash -c "${APPDIR}/bin/app upload"
    bash -c "${APPDIR}/bin/cfn upload"
    if [[ "$ENVTYPE" == production ]]; then
      bash -c "${APPDIR}/bin/cfn update vgh"
    fi
    send_ec2_run_command "$AWS_TAG_ROLE"
  else
    echo 'Deployment is not allowed from pull requests' >&2
  fi
}