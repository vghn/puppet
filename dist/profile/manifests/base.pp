# Base Profile
class profile::base {
  # Standard Library
  include ::stdlib

  # APT
  if $::osfamily == 'Debian' { include ::apt }

  # VG Module
  include ::vg
  include ::vg::time

  # NTP
  include ::ntp

  # SUDO
  class { 'sudo':
    purge               => false,
    config_file_replace => false,
  }
  include ::sudo::configs
}
