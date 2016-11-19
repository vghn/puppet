# Time profile
class profile::time(String $zone = 'Etc/UTC') {

  file { '/etc/localtime':
    source  => "file:///usr/share/zoneinfo/${zone}",
    links   => follow,
    replace => true,
    mode    => '0644',
  }

  case $facts['os']['family'] {
    'Debian': {
      package { 'tzdata':
        ensure => present,
        before => File['/etc/localtime'],
      }
      file { '/etc/timezone':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => inline_template('<%= @zone %>'),
      }
    }
    default: {
      fail("The OS ${::operatingsystem} is not supported by this module.")
    }
  }
}
