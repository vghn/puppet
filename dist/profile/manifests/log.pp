# Centralized Logging Profile
class profile::log (
  Optional[String] $server_address = undef,
  Optional[Integer] $server_port = undef,
) {
  if ($server_address and $server_port) {
    class{'::rsyslog::client':
      remote_servers => [
        {
          host    => $server_address,
          port    => $server_port,
          pattern => '*.*',
        },
      ],
    }

    # monitored file log instance resources
    create_resources(rsyslog::imfile, hiera_hash('rsyslog::imfile', {}))
  }
}
