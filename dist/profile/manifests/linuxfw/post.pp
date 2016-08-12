# Firewall Profile (After)
class profile::linuxfw::post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
