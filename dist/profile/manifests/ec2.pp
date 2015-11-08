# AMI Profile
class profile::ec2 {
  include ::profile::base

  # Ensure essential packages
  ensure_packages([
    'nfs-common',
    'mysql-client',
    'python-pip',
  ])

  # AWS SDK for Ruby
  package {'AWS SDK CLI':
    ensure   => present,
    name     => 'aws-sdk',
    provider => 'puppet_gem',
  }

  # AWS CloudFormation scripts
  package {'AWS CloudFormation':
    ensure   => present,
    name     => 'aws-cfn-bootstrap',
    source   => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    provider => 'pip',
    require  => Package['python-pip'],
  }

  #AWS CodeDeploy
  if ($::os['name'] == 'Ubuntu') {
    ensure_packages([
      'ruby2.0',
      'gdebi-core',
    ])
    wget::fetch {'CodeDeploy Deb':
      source      => 'https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/codedeploy-agent_all.deb',
      destination => '/tmp/codedeploy-agent_all.deb',
    }
    package {'CodeDeploy Agent':
      ensure   => present,
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
  }
}
