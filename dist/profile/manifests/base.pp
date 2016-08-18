# Base Profile
class profile::base {
  # Get values from multiple hierarchy levels
  $ssh_authorized_keys = hiera_hash('ssh_authorized_keys', {})
  $cron_jobs = hiera_hash('cron_jobs', {})
  $packages = $::operatingsystem ? {
    'Ubuntu' => hiera_array("${::operatingsystem}::${::lsbdistcodename}::packages", [])
  }

  # Validate parameters
  validate_hash($ssh_authorized_keys)
  validate_hash($cron_jobs)
  validate_array($packages)

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
  $cron_jobs.each |$name, $cron_params| {
    cron {
      default:
        * =>  {
                ensure => 'present',
                user   => 'root',
              }
      ;
      $name:
        * => $cron_params
      ;
    }
  }

  # SSH Keys
  $ssh_authorized_keys.each |$name, $key_params| {
    ssh_authorized_key { $name:
      * => $key_params
    }
  }

  # Packages
  ensure_packages($packages)

  # Others
  include ::wget
  include ::ntp
}
