# AMI Profile
class profile::ec2 {
  # Check if server is an EC2 instance
  unless $::ec2_metadata { fail('This profile is intended for EC2 instances!') }
  unless $::operatingsystem == 'Ubuntu' {
    fail('Only Ubuntu is supported on EC2 instances!')
  }

  # Get AWS Region
  $region = regsubst(
    $::ec2_metadata['placement']['availability-zone'],
    '^(\w+)\-(\w+)\-(\d)\w','\1-\2-\3'
  )

  # Latest GIT
  include ::apt
  apt::ppa {'ppa:git-core/ppa': package_manage => true}
  class {'::git':
    require => [
      Apt::Ppa['ppa:git-core/ppa'],
      Class['apt::update'],
      ],
  }

  # AWS CloudWatch Logs
  $aws_cloudwatch_logs = hiera_hash('aws_cloudwatch_logs', undef)
  if ($aws_cloudwatch_logs != undef) {
    class { '::cloudwatchlogs': region => $region }
    Concat['/etc/awslogs/awslogs.conf'] -> Exec['cloudwatchlogs-install']
    create_resources(cloudwatchlogs::log, $aws_cloudwatch_logs)
  }

  # AWS CloudFormation scripts
  package {'AWS CloudFormation':
    ensure   => present,
    name     => 'aws-cfn-bootstrap',
    source   => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    provider => 'pip',
  }

  #AWS CodeDeploy
  ensure_packages([
    'ruby2.0',
    'gdebi-core',
  ])
  wget::fetch {'CodeDeploy Deb':
    source      => 'https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/codedeploy-agent_all.deb',
    destination => '/usr/local/src/codedeploy-agent_all.deb',
  }
  package {'CodeDeploy Agent':
    ensure   => present,
    name     => 'codedeploy-agent',
    source   => '/usr/local/src/codedeploy-agent_all.deb',
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

  # AWS Simple Systems Manager Agent
  wget::fetch {'AWS SSM Agent Deb':
    source      => 'https://amazon-ssm-us-east-1.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb',
    destination => '/usr/local/src/amazon-ssm-agent.deb',
  }
  package {'AWS SSM Agent':
    ensure   => present,
    name     => 'amazon-ssm-agent',
    source   => '/usr/local/src/amazon-ssm-agent.deb',
    provider => dpkg,
    require  => [
      Wget::Fetch['AWS SSM Agent Deb'],
    ],
  }
  service {'AWS SSM Agent':
    ensure  => running,
    enable  => true,
    name    => 'amazon-ssm-agent',
    require => Package['AWS SSM Agent'],
  }

  # Ruby Version Manager
  class { '::rvm': }
  # Binaries available at https://rvm.io/binaries
  rvm_system_ruby {'ruby-2.2.1':
    ensure      => 'present',
    default_use => true,
    build_opts  => ['--binary'];
  }

  # JQ JSON Processor
  wget::fetch {'JQ JSON Processor':
    source      => 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64',
    destination => '/usr/local/bin/jq',
  }
  file {'/usr/local/bin/jq':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => [Wget::Fetch['JQ JSON Processor']],
  }
}
