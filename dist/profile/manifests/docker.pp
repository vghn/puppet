# Docker Profile
class profile::docker {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    if $facts['lsbdistid'] == 'Ubuntu' {
      # Docker main class
      class { '::docker':
        package_name                => 'docker-ce',
        package_release             => $facts['lsbdistcodename'],
        package_repos               => 'stable',
        package_source_location     => '[arch=amd64] https://download.docker.com/linux/ubuntu',
        package_key_source          => 'https://download.docker.com/linux/ubuntu/gpg',
        package_key                 => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
        manage_kernel               => false,
        pin_upstream_package_source => false,
        docker_command              => 'dockerd',
        daemon_subcommand           => '',
      }

      # Docker Compose
      class { '::docker::compose':
        version => '1.15.0',
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
