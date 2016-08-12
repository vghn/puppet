# Firewall Profile (After)
class profile::linuxfw::post {
  firewall { '998 drop all forward':
    proto  => 'all',
    chain  => 'FORWARD',
    action => 'drop',
    before => undef,
  }
  firewall { '999 drop all input':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
