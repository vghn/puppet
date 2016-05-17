# Puppet Master Class
class profile::puppet::master {
  # Install post run hook
  $hieradata_bucket = hiera('hieradata_bucket')
  $hieradata_prefix = hiera('hieradata_prefix')
  file {'R10k Post Run Hook':
    ensure  => present,
    path    => '/usr/local/bin/r10k-post-run',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('profile/r10k-post-run.sh.erb'),
  }

  # Install, configure and deploy R10K
  $control_repo = hiera('control_repo')
  $r10k_version = hiera('r10k_version', 'latest')
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
  } ~>
  exec {'R10K deploy environment':
    command   => '/opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose',
    creates   => "${::settings::environmentpath}/production/Puppetfile",
    logoutput => true,
    timeout   => 600,
    require   => Package['r10k'],
  }

  # CSR
  $csr_config_file = '/etc/puppetlabs/csr/config.yml'
  $csr_log_file = '/tmp/csr_sign.log'
  $csr_config = hiera('csr_config', {})
  validate_hash($csr_config)
  $csr_template = '<%= @csr_config.to_yaml %>'

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
