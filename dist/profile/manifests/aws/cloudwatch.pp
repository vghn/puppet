# AWS CloudWatch Logs
class profile::aws::cloudwatch {

  class { '::cloudwatchlogs': region => 'us-east-1' }
  Concat['/etc/awslogs/awslogs.conf'] -> Exec['cloudwatchlogs-install']

  $logs = hiera_hash('profile::aws::cloudwatch::logs', {})
  $logs.each |String $name, Hash $params| {
    cloudwatchlogs::log { $name:
      * => $params;
    }
  }
}
