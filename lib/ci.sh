#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Installing VGS library'
  git clone https://github.com/vghn/vgs.git ~/vgs

  echo 'Install AWS-CLI'
  pip install --user --upgrade awscli

  echo 'Updating Bundler'
  gem update bundler

  cd "${APPDIR}/dist/profile" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
  echo 'Install required testing gems'
  bundle install --without development system_tests --path vendor
}

# CI Test
ci_test(){
  e_info 'Running tests'
  cd "${APPDIR}/dist/profile" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
  bundle exec rake test
}

# CI Deploy
ci_deploy(){
   download_private_data
   upload_artifact
   aws_ec2_send_run_command 'rhea' 'Run puppet' '/opt/vpm/bin/run --data'
}
