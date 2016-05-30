# AWS CloudWatch Logs
class profile::aws::cloudwatch {
  $aws_cloudwatch_logs = hiera_hash('aws_cloudwatch_logs', undef)
  if ($aws_cloudwatch_logs != undef) {
    class { '::cloudwatchlogs': region => 'us-east-1' }
    Concat['/etc/awslogs/awslogs.conf'] -> Exec['cloudwatchlogs-install']
    create_resources(cloudwatchlogs::log, $aws_cloudwatch_logs)
  }
}
