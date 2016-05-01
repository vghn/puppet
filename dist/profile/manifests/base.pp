# Base Profile
class profile::base {
  # Include classes
  include ::stdlib
  include ::apt
  include ::ntp

  # Ensure essential packages
  ensure_packages([
    'curl',
    'nfs-common',
    'mysql-client',
    'wget',
    'tmux',
    'vim',
    'unzip',
  ])

  # SSH Keys
  if ($::ec2_metadata and $::operatingsystem == 'Ubuntu') {
    $user = 'ubuntu'
  } else {
    $user = 'root'
  }
  $ssh_authorized_keys = hiera_hash('ssh_authorized_keys', undef)
  if ($ssh_authorized_keys != undef) {
    create_resources(
      'ssh_authorized_key',
      $ssh_authorized_keys,
      { user => $user }
    )
  }

  # Papertrail Logging
  $log_server_address = hiera('log_server_address', undef)
  $log_server_port = hiera('log_server_port', undef)
  if ($log_server_port and $log_server_port) {
    class{'::rsyslog::client':
      remote_servers => [
        {
          host    => $log_server_address,
          port    => $log_server_port,
          pattern => '*.*',
        },
      ],
    }
  }
}
