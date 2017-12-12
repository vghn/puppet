# Vlad's Docker Profile
class profile::docker_vgh {
  # Docker
  if $facts['virtual'] == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    require ::apt

    $os_string = downcase($facts['os']['name'])

    case $facts['os']['family'] {
    'Debian': {
      apt::source { 'docker':
        location     => "https://download.docker.com/linux/${os_string}",
        architecture => 'amd64',
        release      => $facts['lsbdistcodename'],
        repos        => 'stable',
        key          => {
          'id'     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
          'source' => "https://download.docker.com/linux/${os_string}/gpg",
        },
      }

      package { 'docker-ce':
        ensure  => present,
        require => [Apt::Source['docker'], Class['apt::update']],
      }

      package { ['docker.io','docker-engine']:
        ensure => absent,
      }

      service { 'docker':
        ensure  => running,
        enable  => true,
        require => Package['docker-ce'],
      }
    }
    default: { warning("Docker is not yet supported on ${facts['os']['family']}!") }
    }
  }
}
