# AMI Profile
class profile::ec2 {
  # Check if server is an EC2 instance
  unless $::ec2_metadata {
    warning('This profile is intended for EC2 instances!')
  }
  unless $::operatingsystem == 'Ubuntu' {
    warning('Only Ubuntu is supported on EC2 instances!')
  }

  # Get AWS Region
  if $::ec2_metadata {
    $az = $::ec2_metadata['placement']['availability-zone']
    $region = regsubst($az, '^(\w+)\-(\w+)\-(\d)\w','\1-\2-\3')
  } else {
    $region = 'us-east-1'
  }

  # Latest GIT
  include ::apt
  apt::ppa {'ppa:git-core/ppa': package_manage => true}
  class {'::git':
    require => [
      Apt::Ppa['ppa:git-core/ppa'],
      Class['apt::update'],
      ],
  }

  # monitored file log instance resources
  $logfile_instances = hiera('rsyslog::imfile', {})
  create_resources(rsyslog::imfile, $logfile_instances)

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
  $rvm_system_ruby = hiera('rvm_system_ruby')
  rvm_system_ruby {$rvm_system_ruby:
    ensure      => 'present',
    default_use => true,
    build_opts  => ['--binary'];
  }

  # JQ JSON Processor
  $jq_version = hiera('jq_version')
  wget::fetch {'JQ JSON Processor':
    source      => "https://github.com/stedolan/jq/releases/download/jq-${jq_version}/jq-linux64",
    destination => '/usr/local/bin/jq',
  }
  file {'/usr/local/bin/jq':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => [Wget::Fetch['JQ JSON Processor']],
  }
}
