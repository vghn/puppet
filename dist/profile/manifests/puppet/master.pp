# Puppet Master Class
class profile::puppet::master {
  # Hiera config
  class {'::hiera':
    datadir            => "${::settings::environmentpath}/%{::environment}/data",
    hiera_yaml         => "${::settings::codedir}/hiera.yaml",
    puppet_conf_manage => false,
    create_symlink     => false,
    owner              => 'root',
    group              => 'root',
    hierarchy          => [
      'nodes/%{::trusted.certname}',
      '%{::trusted.domainname}/%{::trusted.hostname}',
      'roles/%{::trusted.extensions.pp_role}',
      'roles/%{role}',
      'private',
      'common',
    ],
  }

  # Install, configure and run R10K
  class {'::r10k':
    sources  => {
      'main' => {
        'remote'  => 'https://github.com/vladgh/puppet.git',
        'basedir' => $::settings::environmentpath,
        'prefix'  => false,
      },
    },
    cachedir => '/opt/puppetlabs/r10k/cache',
    postrun  => ['/bin/bash', '-c', "${::settings::environmentpath}/${environment}/bin/r10k-post-run"],
    provider => 'puppet_gem',
    version  => '2.2.0',
    notify   => Exec['R10K deploy environment'],
  }

  exec {'R10K deploy environment':
    command     => 'r10k deploy environment --puppetfile --verbose',
    path        => ['/opt/puppetlabs/puppet/bin', '/usr/bin'],
    refreshonly => true,
    logoutput   => true,
    timeout     => 600,
  }

  ensure_resource('file', '/usr/local/bin/puppet_vgh_master_update',
    {
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0555',
      content => template('profile/puppet_vgh_master_update.sh.erb'),
    }
  )
}
