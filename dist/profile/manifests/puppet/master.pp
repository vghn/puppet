# Puppet Master Class
class profile::puppet::master {
  # VARs
  $scripts_path = hiera('scripts_path', '/opt/scripts')

  # Ensure directories
  common::mkdir_p {$scripts_path:}

  # Docker Compose File
  $log_server_address = hiera('log_server_address', undef)
  $log_server_port    = hiera('log_server_port', undef)
  file {'Start Logging Container':
    ensure  => present,
    path    => "${scripts_path}/start-logging-container",
    content => template('profile/start-logging-container.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Exec["mkdir_p-${scripts_path}"],
  }
}
