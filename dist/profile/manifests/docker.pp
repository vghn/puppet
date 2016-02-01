# Docker Profile
class profile::docker {
  include ::profile::base

  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    class { '::docker':
      tcp_bind    => 'tcp://0.0.0.0:2375',
      socket_bind => 'unix:///var/run/docker.sock',
    }
  }
}
