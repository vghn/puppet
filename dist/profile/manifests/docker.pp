# Docker Profile
class profile::docker {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    # Docker main class
    if $::lsbdistid == 'Ubuntu' {
      $package_url = 'https://download.docker.com/linux/ubuntu'
    }
    class { '::docker':
      package_name                => 'docker-ce',
      package_key_source          => "${package_url}/gpg",
      package_source_location     => $package_url,
      manage_kernel               => false,
      pin_upstream_package_source => false,
    }

    # Docker Compose
    class { '::docker::compose':
      version => '1.14.0',
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
