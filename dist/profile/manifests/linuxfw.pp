# Firewall Profile
class profile::linuxfw {
  resources { 'firewall':
    purge => false,
  }
  resources { 'firewallchain':
    purge => false,
  }

  Firewall {
    before  => Class['profile::linuxfw::post'],
    require => Class['profile::linuxfw::pre'],
  }

  include ::firewall, ::profile::linuxfw::pre, ::profile::linuxfw::post
}
