# Puppet Agent Class
class profile::puppet::agent {
  # Disable Puppet services
  service {['puppet', 'mcollective', 'pxp-agent']:
    ensure => stopped,
    enable => false,
  }

  # Cron job to run puppet agent
  $minute = fqdn_rand(30, $trusted['certname'])
  cron {'Puppet Run':
    ensure      => present,
    environment => 'PATH="/opt/puppetlabs/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"',
    command     => 'sudo puppet agent --onetime --no-daemonize --verbose --logdest syslog > /dev/null 2>&1',
    minute      => [$minute, $minute+30],
    user        => 'root',
  }
}
