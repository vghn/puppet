# Docker Profile
class profile::docker {
  include ::profile::base

  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    include ::docker
  }
}

