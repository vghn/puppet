class profile::base {
  service { ['puppet', 'mcollective']:
    ensure => stopped,
    enable => false,
  }
}

