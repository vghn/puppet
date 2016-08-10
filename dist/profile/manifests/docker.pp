# Docker Profile
class profile::docker {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    include ::docker

    # Pull images
    $docker_images = hiera('docker_images', {})
    create_resources(docker::image, $docker_images)

    # Run containers
    $docker_run = hiera('docker_run', {})
    create_resources(docker::run, $docker_run)

    # Docker Compose
    $docker_compose_version = hiera('docker_compose_version')
    class {'::docker::compose': version => $docker_compose_version}
  }
}
