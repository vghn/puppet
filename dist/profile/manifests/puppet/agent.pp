# Puppet Agent Class
class profile::puppet::agent{
  # Disable Puppet services
  service {['puppet', 'mcollective', 'pxp-agent']:
    ensure => stopped,
    enable => false,
  }
}
