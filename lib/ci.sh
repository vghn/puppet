#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

set_bundle_directory(){
  cd "${1:-}" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
}

# CI Install
ci_install(){
  echo 'Install VGS library'
  git clone https://github.com/vghn/vgs.git ~/vgs

  echo 'Install AWS-CLI'
  pip install --user --upgrade awscli

  echo 'Update Bundler'
  gem update bundler

  echo 'Install gems'
  set_bundle_directory "$APPDIR"
  bundle install --path vendor

  echo 'Install profile testing gems'
  set_bundle_directory "${APPDIR}/dist/profile"
  bundle install --without development system_tests --path vendor
}

# CI Test
ci_test(){
  e_info 'Run tests'
  set_bundle_directory "$APPDIR"
  bundle exec rake docker:test

  e_info 'Build docker images'
  bundle exec rake docker:build

  e_info 'Run profile tests'
  set_bundle_directory "${APPDIR}/dist/profile"
  bundle exec rake test
}

# CI Deploy
ci_deploy(){
  if [[ "$ENVTYPE" == 'production' ]]; then
    e_info 'Publish docker images'
    set_bundle_directory "$APPDIR"
    bundle exec rake docker:publish
  fi

  e_info 'Deploy command'
  aws_ec2_send_run_command \
    'rhea' \
    'Run puppet' \
    '/opt/vpm/bin/run --update-repo --update-data'
}
