# Puppet Master Class
class profile::puppet::master {
  # VARs
  $control_repo           = hiera('control_repo')
  $hieradata_bucket       = hiera('hieradata_bucket')
  $hieradata_prefix       = hiera('hieradata_prefix')
  $r10k_post_run_hook     = '/etc/puppetlabs/r10k/post-run.sh'
  $r10k_post_run_log_file = '/tmp/r10k_post_run.log'
  $r10k_version           = hiera('r10k_version', 'latest')
  $csr_config_file        = '/etc/puppetlabs/csr/config.yml'
  $csr_log_file           = '/tmp/csr_sign.log'
  $csr_config             = hiera('csr_config', {})

  # Checks
  validate_hash($csr_config)

  # Hooks
  file {'R10k Post Run Hook':
    ensure  => present,
    path    => $r10k_post_run_hook,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('profile/r10k-post-run.sh.erb'),
  }

  # Install and configure R10K
  class {'::r10k':
    sources  => {
      'main' => {
        'remote'  => $control_repo,
        'basedir' => $::settings::environmentpath,
        'prefix'  => false,
      },
    },
    postrun  => [$r10k_post_run_hook],
    cachedir => '/opt/puppetlabs/r10k/cache',
    provider => 'puppet_gem',
    version  => $r10k_version,
    require  => File['R10k Post Run Hook'],
  }

  # Deploy R10K
  exec {'R10K deploy environment':
    command   => '/opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose',
    creates   => "${::settings::environmentpath}/production/.r10k-deploy.json",
    user      => 'root',
    logoutput => true,
    timeout   => 600,
    require   => [ Package['r10k'], File['r10k.yaml'] ],
  }

  # CSR
  file {'/etc/puppetlabs':
    ensure => 'directory',
  } ->
  file {'/etc/puppetlabs/csr':
    ensure => 'directory',
  } ->
  file {'CSR Sign Config':
    ensure  => file,
    path    => $csr_config_file,
    content => inline_template('<%= @csr_config.to_yaml %>'),
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
