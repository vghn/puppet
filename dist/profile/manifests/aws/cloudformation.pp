# AWS CloudFormation Helper Scripts
class profile::aws::cloudformation {
  # AWS CloudFormation scripts
  package { 'AWS CloudFormation':
    ensure   => present,
    name     => 'aws-cfn-bootstrap',
    source   => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    provider => 'pip',
  }

  file { '/usr/local/init/ubuntu/cfn-hup':
    ensure  => 'file',
    mode    => '0755',
    require => Package['AWS CloudFormation'],
  }

  file { '/etc/init.d/cfn-hup':
    ensure  => 'link',
    target  => '/usr/local/init/ubuntu/cfn-hup',
    require => File['/usr/local/init/ubuntu/cfn-hup'],
  }

  service { 'cfn-hup':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/init.d/cfn-hup'],
  }
}
