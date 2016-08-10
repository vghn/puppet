# Base Profile
class profile::base {
  # Standard Library
  include ::stdlib

  # APT
  if $::osfamily == 'Debian' {
    # Patch until the apt module supports Ubuntu 16.04
    ensure_packages('software-properties-common')
    class { '::apt': require => Package['software-properties-common'] }
  }

  # Base firewall policy
  include ::profile::linuxfw

  # VG Module
  include ::vg
  include ::vg::time

  # Security
  class { '::sudo':
    purge               => false,
    config_file_replace => false,
  }
  include ::sudo::configs
  include ::ssh

  # Others
  include ::wget
  include ::ntp
}
