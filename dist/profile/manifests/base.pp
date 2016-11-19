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

  # Security
  class { '::sudo':
    purge               => false,
    config_file_replace => false,
  }
  include ::sudo::configs
  include ::ssh

  # CRON Jobs
  # https://docs.puppet.com/puppet/latest/reference/lang_resources_advanced.html#implementing-the-createresources-function
  $cron_jobs = hiera_hash('profile::base::cron_jobs', {})
  $cron_jobs.each |String $name, Hash $params| {
    cron {
      default: * => {
                      ensure => 'present',
                      user   => 'root',
                    };
      $name: * => $params;
    }
  }

  # SSH Keys
  $ssh_authorized_keys = hiera_hash('profile::base::ssh_authorized_keys', {})
  $ssh_authorized_keys.each |String $name, Hash $params| {
    ssh_authorized_key { $name:
      * => $params;
    }
  }

  # INI Settings
  $ini_settings = hiera_hash('profile::base::ini_settings', {})
  $ini_settings.each |String $name, Hash $params| {
    ini_setting { $name:
      * => $params;
    }
  }

  # Packages
  $packages = $::operatingsystem ? {
    'Ubuntu' => hiera_array("profile::base::${::operatingsystem}::${::lsbdistcodename}::packages", [])
  }
  ensure_packages($packages)

  # Others
  include ::wget
  include ::ntp
  include ::profile::time
  include ::profile::misc
}
