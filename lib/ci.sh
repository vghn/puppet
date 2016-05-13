#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Installing VGS library'
  mkdir -p ~/vgs
  wget -qO- https://s3.amazonaws.com/vghn/vgs.tgz | tar xz -C ~/vgs

  echo 'Install AWS-CLI'
  pip install --user --upgrade awscli

  cd "${APPDIR}/dist/profile" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
  e_info 'Install required testing gems'
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
  aws_ec2_send_run_command 'zeus' 'Deploy R10K environment' 'sudo /opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose'
}
