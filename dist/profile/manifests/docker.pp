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
    class { '::docker::compose':
      version => '1.12.0',
    }

    # Pull images
    lookup(
      'profile::docker::images', {'merge' => 'hash', 'default_value' => {}}
    ).each |String $name, Hash $params| {
      docker::image { $name:
        * => $params;
      }
    }

    # Run containers
    lookup(
      'profile::docker::run', {'merge' => 'hash', 'default_value' => {}}
    ).each |String $name, Hash $params| {
      docker::run { $name:
        * => $params;
      }
    }
  }
}
