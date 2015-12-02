# Docker Profile
class profile::docker {
  include ::profile::base

  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    class {'::docker': package_key_source => 'http://apt.dockerproject.org/gpg'}
  }
}

