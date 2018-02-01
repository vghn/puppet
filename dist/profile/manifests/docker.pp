# Docker Profile
class profile::docker {
  # Docker
  if $facts['virtual'] == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    if $facts['os']['family'] == 'Debian' {
      # Docker main class
      class { '::docker':
        docker_ce_package_name => 'docker-ce',
        docker_ce_channel      => 'edge'
      }

      # Docker Compose
      class { '::docker::compose':
        version => '1.18.0',
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
