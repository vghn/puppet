# Firewall Profile (Before)
class profile::linuxfw::pre {
  Firewall {
    require => undef,
  }

  # Only filter INPUT (leave other chains; for example the docker chain)
  firewallchain { 'INPUT:filter:IPv4':
    purge  => true,
    ignore => [
      # ignore the fail2ban jump rule
      '-j fail2ban-ssh',
      # ignore any rules with "ignore" (case insensitive) in the comment in the rule
      '--comment "[^"](?i:ignore)[^"]"',
      ],
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
    state  => ['NEW', 'ESTABLISHED'],
    action => 'accept',
  }

  # Extra rules defined in Hiera
  create_resources(firewall, hiera_hash('firewall_rules', {}))
}
