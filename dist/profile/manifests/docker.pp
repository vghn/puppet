# Docker Profile
class profile::docker(String $compose_version) {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    # Docker main class
    include ::docker

    # Pull images
    $images = hiera_hash('profile::docker::images', {})
    create_resources(docker::image, $images)

    # Run containers
    $run = hiera_hash('profile::docker::run', {})
    create_resources(docker::run, $run)

    # Docker Compose
    class {'::docker::compose': version => $compose_version}
  }
}
