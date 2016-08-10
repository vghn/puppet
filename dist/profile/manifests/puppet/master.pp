# Puppet Master Class
class profile::puppet::master {
  firewall { '100 allow puppet access':
    dport  => 8140,
    proto  => 'tcp',
    action => 'accept',
  }
}
