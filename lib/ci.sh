#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

set_bundle_directory(){
  cd "${1:-}" || return 1
  export BUNDLE_GEMFILE=$PWD/Gemfile
}

publish_artifact(){
  local archive="vpm_${ENVTYPE}_${VERSION}-${GIT_SHA1}.tgz"
  local archive_latest="vpm_${ENVTYPE}.tgz"
  local archive_path="${TMPDIR}/${archive}"

  e_info 'Pack artifact'
  if ! tar zcvf "$archive_path" \
    .env hieradata vault\
    bin dist/{profile,role}/manifests lib manifests \
    docker-compose.yml environment.conf envrc Puppetfile \
    CHANGELOG.md LICENSE README.md VERSION;
  then
    e_abort "Could not create ${archive_path}"
  fi

  e_info 'Upload artifact'
  if ! aws s3 cp "$archive_path" "${ARTIFACTS_S3PATH}/${archive}"; then
    e_abort "Could not upload ${archive_path} to ${ARTIFACTS_S3PATH}/${archive}"
  fi

  e_info 'Mark latest version'
  if ! aws s3 cp "${ARTIFACTS_S3PATH}/${archive}" "${ARTIFACTS_S3PATH}/${archive_latest}"; then
    e_abort "Could not upload ${ARTIFACTS_S3PATH}/${archive} to ${ARTIFACTS_S3PATH}/${archive_latest}"
  fi
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

  publish_artifact

  e_info 'Deploy command'
  aws_ec2_send_run_command 'rhea' 'Start VPM' '/opt/vpm/bin/start'
}
