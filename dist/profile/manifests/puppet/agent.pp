# Puppet Agent Class
class profile::puppet::agent{
  # Disable Puppet services
  service {['puppet', 'mcollective']:
    ensure => stopped,
    enable => false,
  }
}
