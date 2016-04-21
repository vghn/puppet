# Docker Profile
class profile::docker {
  # Docker
  if $::virtual == 'docker' {
    warning('Docker in Docker is not yet supported!')
  } else {
    class { '::docker':
      tcp_bind    => 'tcp://0.0.0.0:2375',
      socket_bind => 'unix:///var/run/docker.sock',
    }

    # Docker Compose
    $docker_compose_version = hiera('docker_compose_version')
    class {'::docker::compose': version => $docker_compose_version}

    # Docker Machine
    $docker_machine_version = hiera('docker_machine_version')
    wget::fetch {'Docker-Machine Binary':
      source      => "https://github.com/docker/machine/releases/download/v${docker_machine_version}/docker-machine-${::kernel}-${::os['hardware']}",
      destination => '/usr/local/bin/docker-machine',
    }
    file {'/usr/local/bin/docker-machine':
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => [Wget::Fetch['Docker-Machine Binary']],
    }

    # AWS ECS
    $aws_cfn_ecs_cluster = hiera('aws_cfn_ecs_cluster', 'default')
    if $::ec2_metadata {
      file { '/var/log/ecs':
        ensure => 'directory',
      } ->
      file { '/var/lib/ecs':
        ensure => 'directory',
      } ->
      file { '/var/lib/ecs/data':
        ensure => 'directory',
      } ->
      docker::run {'ecs-agent':
        image         => 'amazon/amazon-ecs-agent:latest',
        privileged    => true,
        detach        => true,
        restart       => 'always',
        volumes       => [
          '/var/run/docker.sock:/var/run/docker.sock',
          '/var/log/ecs/:/log:Z',
          '/var/lib/ecs/data:/data:Z',
          '/sys/fs/cgroup:/sys/fs/cgroup:ro',
          '/var/run/docker/execdriver/native:/var/lib/docker/execdriver/native:ro',
        ],
        ports         => '51678:51678',
        env           => [
          'ECS_LOGFILE=/log/ecs-agent.log',
          'ECS_LOGLEVEL=info',
          'ECS_DATADIR=/data',
          "ECS_CLUSTER=${aws_cfn_ecs_cluster}",
        ],
        pull_on_start => true,
        require       => Service['docker'],
      }
    }
  }
}
