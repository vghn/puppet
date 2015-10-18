# AMI Profile
class profile::ec2 {
  include profile::base

  # Ensure essential packages
  ensure_packages([
    'nfs-common',
    'mysql-client',
    'ruby2.0',
    'gdebi-core'
  ])

  # AWS SDK for Ruby
  package {'aws-sdk':
    ensure   => installed,
    provider => puppet_gem,
  }

  # AWS CloudFormation scripts
  package {'AWS CloudFormation':
    ensure   => installed,
    name     => 'aws-cfn-bootstrap',
    source   => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    provider => pip,
  }

  # AWS CodeDeploy
  wget::fetch {'CodeDeploy Deb':
    source      => 'https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/codedeploy-agent_all.deb',
    destination => '/tmp/codedeploy-agent_all.deb',
  }
  package {'CodeDeploy Agent':
    ensure   => latest,
    name     => 'codedeploy-agent',
    source   => '/tmp/codedeploy-agent_all.deb',
    provider => dpkg,
    require  => [
      Wget::Fetch['CodeDeploy Deb'],
      Package['ruby2.0', 'gdebi-core']
    ],
  }
  service {'CodeDeploy Service':
    ensure  => running,
    enable  => true,
    name    => 'codedeploy-agent',
    require => Package['CodeDeploy Agent'],
  }

  # Docker-Compose
  wget::fetch {'Docker-Compose':
    source      => "https://github.com/docker/compose/releases/download/1.4.0/docker-compose-${::kernel}-${::os['hardware']}",
    destination => '/usr/local/bin/docker-compose',
    require     => Class['Docker'],
  }
  file {'/usr/local/bin/docker-compose':
    mode    => '0755',
    require => Wget::Fetch['Docker-Compose'],
  }
}

