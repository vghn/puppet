# Docker Profile
class profile::docker {
  # Docker
  if $facts['virtual'] == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    if $facts['os']['name'] == 'Ubuntu' {
      # Docker main class
      class { '::docker':
        package_name  => 'docker-ce',
        manage_kernel => false,
      }

      # Docker Compose
      class { '::docker::compose':
        version => '1.17.1',
      }

      # Pull images
      lookup({
        'name'          => 'profile::docker::images',
        'merge'         => 'hash',
        'default_value' => {}
      }).each |String $name, Hash $params| {
        docker::image { $name:
          * => $params;
        }
      }

      # Run containers
      lookup({
        'name'          => 'profile::docker::run',
        'merge'         => 'hash',
        'default_value' => {}
      }).each |String $name, Hash $params| {
        docker::run { $name:
          * => $params;
        }
      }
    }
  }
}
