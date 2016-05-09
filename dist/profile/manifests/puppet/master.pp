# Puppet Master Class
class profile::puppet::master {

  # VARs
  $hiera_data_dir = "${::settings::environmentpath}/%{::environment}/hieradata"
  $control_repo   = hiera('control_repo')
  $r10k_version   = hiera('r10k_version', 'latest')

  # Hiera config
  class {'::hiera':
    datadir            => $hiera_data_dir,
    hiera_yaml         => "${::settings::codedir}/hiera.yaml",
    puppet_conf_manage => false,
    create_symlink     => false,
    owner              => 'root',
    group              => 'root',
    hierarchy          => [
      'nodes/%{::trusted.certname}',
      '%{::trusted.domainname}/%{::trusted.hostname}',
      'roles/%{::trusted.extensions.pp_role}',
      'roles/%{::role}',
      'projects/%{::trusted.extensions.pp_project}',
      'projects/%{::project}',
      'virtual/%{::virtual}',
      'osfamily/%{::osfamily}',
      'private',
      'common',
    ],
  }

  # Install post run hook
  file {'R10k Post Run Hook':
    ensure  => present,
    path    => '/usr/local/bin/r10k-post-run',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('profile/r10k-post-run.sh.erb'),
  }

  # Install, configure and run R10K
  class {'::r10k':
    sources  => {
      'main' => {
        'remote'  => $control_repo,
        'basedir' => $::settings::environmentpath,
        'prefix'  => false,
      },
    },
    postrun  => ['/usr/local/bin/r10k-post-run'],
    cachedir => '/opt/puppetlabs/r10k/cache',
    provider => 'puppet_gem',
    version  => $r10k_version,
    require  => File['R10k Post Run Hook'],
  }

  # CSR
  $csr_config_file = '/etc/puppetlabs/csr/config.yml'
  $csr_log_file = '/tmp/csr_sign.log'
  $csr_config = hiera('csr_config', {})
  validate_hash($csr_config)
  $csr_template = "<%= @csr_config.to_yaml %>"

  file {'/etc/puppetlabs':
    ensure => 'directory',
  } ->
  file {'/etc/puppetlabs/csr':
    ensure => 'directory',
  } ->
  file {'CSR Sign Config':
    ensure  => file,
    path    => $csr_config_file,
    content => inline_template($csr_template),
  } ->
  file {'CSR Sign':
    ensure  => present,
    path    => '/etc/puppetlabs/csr/sign',
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    content => template('profile/sign.sh.erb'),
  }
}
