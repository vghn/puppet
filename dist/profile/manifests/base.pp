# Base Profile
class profile::base {
  # Standard Library
  include ::stdlib

  # APT
  if $facts['os']['family'] == 'Debian' {
    # Patch until the apt module supports Ubuntu 16.04
    ensure_packages('software-properties-common')
    class { '::apt': require => Package['software-properties-common'] }
    include unattended_upgrades
  }

  # Security
  class { '::sudo':
    purge               => false,
    config_file_replace => false,
  }
  include ::sudo::configs
  include ::ssh

  # CRON Jobs
  hiera_hash('profile::base::cron_jobs', {}).each |String $name, Hash $params| {
    cron {
      default: * => {
                      ensure => 'present',
                      user   => 'root',
                    };
      $name: * => $params;
    }
  }

  # SSH Keys
  hiera_hash('profile::base::ssh_authorized_keys', {}).each |String $name, Hash $params| {
    ssh_authorized_key { $name:
      * => $params;
    }
  }

  # INI Settings
  hiera_hash('profile::base::ini_settings', {}).each |String $name, Hash $params| {
    ini_setting { $name:
      * => $params;
    }
  }

  # Packages
  $packages = $facts['os']['name'] ? {
    'Ubuntu' => hiera_array("profile::base::${facts['os']['name']}::${facts['os']['distro']['codename']}::packages", [])
  }
  ensure_packages($packages)

  # Others
  include ::wget
  include ::ntp
  include ::profile::time
  include ::profile::misc
}
