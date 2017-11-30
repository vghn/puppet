# Centralized Logging Profile
class profile::log (
  Optional[String]  $server_address = undef,
  Optional[Integer] $server_port = undef,
  Optional[Boolean] $ssl = false,
  Optional[String]  $ssl_ca = undef,
  Optional[String]  $ssl_cert = undef,
  Optional[String]  $ssl_key = undef,
  Optional[String]  $ssl_auth_mode = 'anon',
  Optional[String]  $ssl_permitted_peer = undef,
) {

  # Logs
  if $facts['os']['name'] == 'Ubuntu' {
    class {'rsyslog': purge_rsyslog_d => true,}
  }

  if ($server_address and $server_port) {
    if ($ssl and $ssl_ca) {
      # Populate certificates
      file {'Log Certificates':
        ensure  => 'directory',
        path    => '/etc/ssl/log_certs',
        purge   => true,
        recurse => true,
        source  => "puppet:///modules/${module_name}/log_certs",
      }

      # Configure client
      class{'::rsyslog::client':
        ssl                => true,
        ssl_ca             => $ssl_ca,
        ssl_cert           => $ssl_cert,
        ssl_key            => $ssl_key,
        ssl_auth_mode      => $ssl_auth_mode,
        ssl_permitted_peer => $ssl_permitted_peer,
        log_local          => true,
        split_config       => true,
        remote_servers     => [
          {
            host    => $server_address,
            port    => $server_port,
            pattern => '*.*',
          },
        ],
        require            => File['Log Certificates'],
      }
    } else {
      # Configure client
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
    }

    # Extra monitored files
    lookup({
      'name'          => 'profile::rsyslog::imfile',
      'merge'         => 'hash',
      'default_value' => {}
    }).each |String $name, Hash $params| {
      rsyslog::imfile { $name:
        * => $params;
      }
    }
  }
}
