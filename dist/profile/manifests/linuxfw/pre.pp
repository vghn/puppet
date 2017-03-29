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
      '-j f2b-sshd',
      # ignore any rules with "ignore" (case insensitive) in the comment in the rule
      '--comment "[^"](?i:ignore)[^"]"',
      ],
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }
  -> firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  -> firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }
  -> firewall { '003 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
  -> firewall { '004 accept ssh connections':
    proto  => 'tcp',
    dport  => '22',
    state  => ['NEW', 'ESTABLISHED'],
    action => 'accept',
  }

  # Extra rules
  lookup(
    'profile::linuxfw::rules', {'merge' => 'hash', 'default_value' => {}}
  ).each |String $name, Hash $params| {
    firewall { $name:
      * => $params;
    }
  }
}
