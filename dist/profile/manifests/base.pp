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

  # Users
  lookup(
    'profile::base::users', {'merge' => 'hash', 'default_value' => {}}
  ).each |String $name, Hash $params| {
    user {
      default: * => {
                      ensure => 'present',
                    };
      $name: * => $params;
    }
  }

  # SSH Keys
  lookup(
    'profile::base::ssh_authorized_keys', {'merge' => 'hash', 'default_value' => {}}
  ).each |String $name, Hash $params| {
    ssh_authorized_key {
      default: * => {
                      ensure => 'present',
                      user   => 'root',
                    };
      $name: * => $params;
    }
  }

  # CRON Jobs
  lookup(
    'profile::base::cron_jobs', {'merge' => 'hash', 'default_value' => {}}
  ).each |String $name, Hash $params| {
    cron {
      default: * => {
                      ensure => 'present',
                      user   => 'root',
                    };
      $name: * => $params;
    }
  }

  # INI Settings
  lookup(
    'profile::base::ini_settings', {'merge' => 'hash', 'default_value' => {}}
  ).each |String $name, Hash $params| {
    ini_setting { $name:
      * => $params;
    }
  }

  # Packages
  $packages = $facts['os']['name'] ? {
    'Ubuntu' => lookup("profile::base::${facts['os']['name']}::${facts['os']['distro']['codename']}::packages", {'merge' => 'unique', 'default_value' => []})
  }
  ensure_packages($packages)

  # Others
  include ::wget
  include ::ntp
  include ::profile::time
  include ::profile::misc
}
