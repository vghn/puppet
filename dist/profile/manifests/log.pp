# Centralized Logging Profile
class profile::log (
  Optional[String] $server_address = undef,
  Optional[Integer] $server_port = undef,
) {
  # Logs
  if $facts['os']['name'] == 'Ubuntu' {
    class {'rsyslog': purge_rsyslog_d => true,}
  }

  if ($server_address and $server_port) {
    class{'::rsyslog::client':
      log_local      => true,
      split_config   => true,
      remote_servers => [
        {
          host    => $server_address,
          port    => $server_port,
          pattern => '*.*',
        },
      ],
    }

    # Extra monitored files
    lookup(
      'profile::rsyslog::imfile', {'merge' => 'hash', 'default_value' => {}}
    ).each |String $name, Hash $params| {
      rsyslog::imfile { $name:
        * => $params;
      }
    }
  }
}
