# Firewall Profile (After)
class profile::linuxfw::post {
  firewall { '999 drop all input':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
