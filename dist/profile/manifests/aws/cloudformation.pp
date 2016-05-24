# CloudFormation Profile
class profile::aws::cloudformation {
  require ::profile::base

  # AWS CloudFormation scripts
  package {'AWS CloudFormation':
    ensure   => present,
    name     => 'aws-cfn-bootstrap',
    source   => 'https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz',
    provider => 'pip',
    require  => Package['python-pip'],
  }
}
