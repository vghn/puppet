# AWS CloudFormation Helper Scripts
class profile::aws::cloudformation {
  # AWS CloudFormation scripts
  package { 'AWS CloudFormation':
    ensure   => present,
    name     => 'aws-cfn-bootstrap',
    source   => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    provider => 'pip',
  }

  file { '/etc/init.d/cfn-hup':
    ensure  => 'link',
    target  => '/usr/local/init/ubuntu/cfn-hup',
    require => Package['AWS CloudFormation'],
  }

  service { 'cfn-hup':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/init.d/cfn-hup'],
  }
}
