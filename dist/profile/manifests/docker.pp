# Docker Profile
class profile::docker {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    # Docker main class
    class { '::docker':
      manage_kernel               => false,
      pin_upstream_package_source => false,
    }

    # Docker Compose
    include ::docker::compose

    # Pull images
    hiera_hash('profile::docker::images', {}).each |String $name, Hash $params| {
      docker::image { $name:
        * => $params;
      }
    }

    # Run containers
    hiera_hash('profile::docker::run', {}).each |String $name, Hash $params| {
      docker::run { $name:
        * => $params;
      }
    }
  }
}
