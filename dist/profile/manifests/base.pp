# Base Profile
class profile::base {
  # Logging
  $log_server_address = hiera('log_server_address', undef)
  $log_server_port = hiera('log_server_port', undef)
  if ($log_server_address and $log_server_port) {
    class{'::rsyslog::client':
      remote_servers => [
        {
          host    => $log_server_address,
          port    => $log_server_port,
          pattern => '*.*',
        },
      ],
    }

    # monitored file log instance resources
    $logfile_instances = hiera('rsyslog::imfile', {})
    create_resources(rsyslog::imfile, $logfile_instances)
  }

  # Include essential classes
  include ::stdlib
  include ::apt
  include ::ntp
  include ::python
  include ::vg
  include ::vg::time

  # Ensure essential packages
  ensure_packages([
    'curl',
    'htop',
    'mysql-client',
    'nfs-common',
    'tmux',
    'unzip',
    'vim',
    'wget',
  ])
}
