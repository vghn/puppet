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
  Optional[Boolean] $relay_server = false,
) {

  # Logs
  if $facts['os']['name'] == 'Ubuntu' {
    class {'rsyslog': purge_rsyslog_d => true,}
  }

  if ($server_address and $server_port) {
    if ($ssl and $ssl_ca) {
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
            host     => $server_address,
            port     => $server_port,
            pattern  => '*.*',
            protocol => 'tcp',
          },
        ],
        require            => Class['profile::ca_certs'],
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
  }

  # UDP Relay
  if $relay_server {
    class { 'rsyslog::server':
      relay_server => true,
      enable_udp   => true,
      enable_tcp   => false,
      enable_relp  => false,
    }
  }

  # Extra monitored files
  lookup({
    'name'          => 'profile::log::imfile',
    'merge'         => 'hash',
    'default_value' => {}
  }).each |String $name, Hash $params| {
    rsyslog::imfile { $name:
      * => $params;
    }
  }
}
