#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Update Bundler'
  gem update bundler

  echo 'Install profile testing gems'
  set_bundle_directory "${APPDIR}/dist/profile"
  bundle install --without development system_tests --path vendor/bundle
}

# CI Test
ci_test(){
  e_info 'Run profile tests'
  set_bundle_directory "${APPDIR}/dist/profile"
  bundle exec rake test
}
