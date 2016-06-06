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

  # R10k Deploy Script
  file {'R10k Deploy':
    ensure  => present,
    path    => "${scripts_path}/r10k-deploy",
    source  => 'puppet:///modules/profile/r10k-deploy',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Exec["mkdir_p-${scripts_path}"],
  }

  # R10k Post Run Hook
  file {'R10k Post Run Hook':
    ensure  => present,
    path    => "${scripts_path}/r10k-post-run",
    source  => 'puppet:///modules/profile/r10k-post-run',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Exec["mkdir_p-${scripts_path}"],
  }
}
