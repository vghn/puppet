# Firewall Profile
class profile::linuxfw {
  resources { 'firewall':
    purge => true,
  }

  Firewall {
    before  => Class['profile::linuxfw::post'],
    require => Class['profile::linuxfw::pre'],
  }

  include ::firewall, ::profile::linuxfw::pre, ::profile::linuxfw::post
}
