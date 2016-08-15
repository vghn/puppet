#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Install AWS-CLI'
  pip install --user --upgrade awscli

  echo 'Install VGS library'
  git clone https://github.com/vghn/vgs.git ~/vgs

  echo 'Update Bundler'
  gem update bundler

  if [[ "${USE_DOCKER:-}" == 'true' ]]; then
    echo 'Updating docker'
    sudo apt-get -qy update
    sudo apt-get -qy \
      -o Dpkg::Options::="--force-confdef" \
      -o Dpkg::Options::="--force-confold" \
      install docker-engine

    echo 'Install gems'
    set_bundle_directory "$APPDIR"
    bundle install --path vendor/bundle

    case "${DOCKER_IMAGE:-}" in
      data)
        echo 'Build data docker image'
        bundle exec rake docker:data:build
        ;;
      server)
        echo 'Build server docker image'
        bundle exec rake docker:server:build
        ;;
    esac
  else
    echo 'Install profile testing gems'
    set_bundle_directory "${APPDIR}/dist/profile"
    bundle install --without development system_tests --path vendor/bundle
  fi
}

# CI Test
ci_test(){
  if [[ "${USE_DOCKER:-}" == 'true' ]]; then
    set_bundle_directory "$APPDIR"
    case "${DOCKER_IMAGE:-}" in
      data)
        e_info 'Test data docker image'
        bundle exec rake docker:data:spec
        ;;
      server)
        e_info 'Test data docker image'
        bundle exec rake docker:server:spec
        ;;
    esac
  else
    e_info 'Run profile tests'
    set_bundle_directory "${APPDIR}/dist/profile"
    bundle exec rake test
  fi
}

# CI Deploy
ci_deploy(){
  e_info 'Get private data'
  download_private_data

  if [[ "${USE_DOCKER:-}" == 'true' ]]; then
    set_bundle_directory "$APPDIR"

    e_info 'Login to Docker Registry'
    docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";

    case "${DOCKER_IMAGE:-}" in
      data)
        e_info 'Publish data docker image'
        bundle exec rake docker:data:publish
        ;;
      server)
        e_info 'Publish docker images'
        bundle exec rake docker:server:publish
        ;;
    esac
  fi

  # SSH Deployment
  eval "$(ssh-agent -s)"
  chmod 600 "${APPDIR}/vault/deploy_key"
  ssh-add "${APPDIR}/vault/deploy_key"
  ssh-keyscan -H puppet.ghn.me >> ~/.ssh/known_hosts
  ssh ubuntu@puppet.ghn.me 'whoami'
}
