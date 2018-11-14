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
        content => "${zone}\n",
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${facts['os']['family']} distribution.")
    }
  }
}
