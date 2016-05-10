# Puppet Agent Class
class profile::puppet::agent {
  # Disable Puppet service
  service {'puppet':
    ensure => stopped,
    enable => false,
  }

  # Cron job to run puppet agent
  $minute = fqdn_rand(30, $trusted['certname'])
  cron {'Puppet Run':
    ensure  => present,
    command => 'sudo /opt/puppetlabs/bin/puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1',
    minute  => [$minute, $minute+30],
    user    => 'root',
  }
}
