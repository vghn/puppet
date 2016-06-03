# Zeus Role (VGH AWS On-Demand Instances)
class role::zeus {
  include ::profile::base
  include ::profile::swap
  include ::profile::git
  include ::profile::jq
  include ::profile::puppet::agent
  include ::profile::aws::cloudformation
  include ::profile::aws::ssm
  include ::profile::aws::s3fs
  include ::profile::docker
  include ::profile::rvm

  # VARs
  $project_path = hiera(project_path, "/opt/${real_role}")

  # Ensure directories
  common::mkdir_p {"$project_path/scripts":}

  # Docker Compose File
  $log_server_address = hiera('log_server_address', undef)
  $log_server_port    = hiera('log_server_port', undef)
  file {'Docker Compose':
    ensure  => present,
    path    => "${project_path}/docker-compose.yaml",
    content => template('role/zeus/docker-compose.yaml.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Exec["mkdir_p-${project_path}"]
  }

  # R10k Post Run Hook
  file {'R10k Post Run Hook':
    ensure  => present,
    path    => "${project_path}/scripts/r10k-post-run",
    source  => 'puppet:///modules/role/zeus/r10k-post-run',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Exec["mkdir_p-${project_path}"]
  }

  # Policy based CSR auto sign script
  file {'CSR Auto Sign':
    ensure  => present,
    path    => "${project_path}/scripts/csr-sign",
    source  => 'puppet:///modules/role/zeus/csr-sign',
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    require => Exec["mkdir_p-${project_path}"]
  }
}
