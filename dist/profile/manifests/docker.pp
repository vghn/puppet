# Docker Profile
class profile::docker {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    # Fix until the docker module supports the latest repository and package
    if $facts['os']['name'] == 'Ubuntu' {
      require ::apt

      apt::key { 'docker':
        source => 'https://download.docker.com/linux/ubuntu/gpg',
        id     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
      }

      apt::source { 'docker':
        location => 'https://download.docker.com/linux/ubuntu',
        repos    => 'stable',
        release  => "ubuntu-${facts['os']['distro']['codename']}",
        require  => Apt::Key['docker'],
      }

      package { 'docker-ce':
        ensure  => present,
        require => [Apt::Source['docker'], Class['apt::update']],
      }

      package { ['docker.io','docker-engine']:
        ensure => absent,
      }
    }

    # # Docker main class
    # class { '::docker':
      # manage_kernel               => false,
      # pin_upstream_package_source => false,
    # }

    # # Docker Compose
    # class { '::docker::compose':
      # version => '1.14.0',
    # }

    # # Pull images
    # lookup(
      # 'profile::docker::images', {'merge' => 'hash', 'default_value' => {}}
    # ).each |String $name, Hash $params| {
      # docker::image { $name:
        # * => $params;
      # }
    # }

    # # Run containers
    # lookup(
      # 'profile::docker::run', {'merge' => 'hash', 'default_value' => {}}
    # ).each |String $name, Hash $params| {
      # docker::run { $name:
        # * => $params;
      # }
    # }
  }
}
