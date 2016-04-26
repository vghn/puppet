# Puppet Agent Class
class profile::puppet::agent {
  # Disable Puppet service
  service {'puppet':
    ensure => stopped,
    enable => false,
  }

  # Cron job to run puppet agent
  cron {'Puppet Run':
    ensure  => present,
    user    => 'root',
    minute  => fqdn_rand(60),
    command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize --logdest syslog > /dev/null 2>&1',
  }
}
