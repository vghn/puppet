# Firewall Profile (Before)
class profile::linuxfw::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept related established rules':
    proto  => 'all',
    state  => ['ESTABLISHED', 'RELATED'],
    action => 'accept',
  }
  firewall { '001 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '002 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '003 accept ssh connections':
    proto  => 'tcp',
    dport  => '22',
    state  => 'NEW',
    action => 'accept',
  }

  # Extra rules defined in Hiera
  create_resources(firewall, hiera_hash('firewall_rules', {}))
}
