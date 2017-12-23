# Base Profile
class profile::base {
  # Standard Library
  include ::stdlib

  # APT
  if $facts['os']['family'] == 'Debian' {
    # Patch until the apt module supports Ubuntu 16.04
    ensure_packages('software-properties-common')
    class { '::apt': require => Package['software-properties-common'] }

    if $facts['os']['name'] == 'Ubuntu' {
      # Upgrade system
      class { 'unattended_upgrades':
        auto    => { 'reboot' => true },
        origins => [
          '${distro_id}:${distro_codename}', #lint:ignore:single_quote_string_with_variables
          '${distro_id}:${distro_codename}-updates', #lint:ignore:single_quote_string_with_variables
          '${distro_id}:${distro_codename}-security', #lint:ignore:single_quote_string_with_variables
        ]
      }
    } else {
      class { 'unattended_upgrades':
        auto    => { 'reboot' => true },
      }
    }
  }

  # Security
  class { '::sudo':
    purge               => false,
    config_file_replace => false,
  }
  include ::sudo::configs
  include ::ssh

  # Users
  lookup({
    'name'          => 'profile::base::users',
    'merge'         => 'hash',
    'default_value' => {}
  }).each |String $name, Hash $params| {
    user {
      default: * => {
                      ensure => 'present',
                      shell  => '/bin/bash',
                    };
      $name: * => $params;
    }
  }

  # SSH Keys(make sure the name us unique, even with existing keys)
  lookup({
    'name'          => 'profile::base::ssh_authorized_keys',
    'merge'         => 'hash',
    'default_value' => {}
  }).each |String $name, Hash $params| {
    ssh_authorized_key {
      default: * => {
                      ensure => 'present',
                      user   => 'root',
                    };
      $name: * => $params;
    }
  }

  # CRON Jobs
  lookup({
    'name'          => 'profile::base::cron_jobs',
    'merge'         => 'hash',
    'default_value' => {}
  }).each |String $name, Hash $params| {
    cron {
      default: * => {
                      ensure => 'present',
                      user   => 'root',
                    };
      $name: * => $params;
    }
  }

  # INI Settings
  lookup({
    'name'          => 'profile::base::ini_settings',
    'merge'         => 'hash',
    'default_value' => {}
  }).each |String $name, Hash $params| {
    ini_setting { $name:
      * => $params;
    }
  }

  # Packages
  $packages = $facts['os']['name'] ? {
    'Ubuntu' => lookup({
      'name'          => "profile::base::${facts['os']['name']}::${facts['lsbdistcodename']}::packages",
      'merge'         => 'unique',
      'default_value' => []
    })
  }
  ensure_packages($packages)

  # Others
  include ::wget
  include ::ntp
  include ::profile::time
  include ::profile::misc
}
