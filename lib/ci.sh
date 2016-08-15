#!/usr/bin/env bash
# Continuous Integration / Continuous Deployment tasks

# CI Install
ci_install(){
  echo 'Install VGS library'
  git clone https://github.com/vghn/vgs.git ~/vgs

  echo 'Update Bundler'
  gem update bundler

  if [[ "${USE_DOCKER:-}" == 'true' ]]; then
    echo 'Install AWS-CLI'
    pip install --user --upgrade awscli

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
        bundle exec rake docker:build:data
        ;;
      server)
        echo 'Build server docker image'
        bundle exec rake docker:build:server
        ;;
      *)
        echo 'Build docker images'
        bundle exec rake docker:build
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
    e_info 'Get private data'
    download_private_data

    set_bundle_directory "$APPDIR"
    case "${DOCKER_IMAGE:-}" in
      data)
        e_info 'Test data docker image'
        bundle exec rake docker:spec:data
        ;;
      server)
        e_info 'Test data docker image'
        bundle exec rake docker:spec:server
        ;;
      *)
        e_info 'Test docker images'
        bundle exec rake docker:spec:
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
  if [[ "${USE_DOCKER:-}" == 'true' ]] && [[ "$ENVTYPE" == 'production' ]]; then
    set_bundle_directory "$APPDIR"

    e_info 'Login to Docker Registry'
    docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";

    case "${DOCKER_IMAGE:-}" in
      data)
        e_info 'Publish data docker image'
        bundle exec rake docker:publish:data
        ;;
      server)
        e_info 'Publish docker images'
        bundle exec rake docker:publish:data
        ;;
      *)
        e_info 'Publish docker images'
        bundle exec rake docker:publish
        ;;
    esac

  fi
}
