# Bootstrap manifest
info("Bootstraping ${role}")

# Essential packages
ensure_packages ([
  'curl',
  'python-pip',
])

# Include classes
include ::apt

# Install latest GIT
apt::ppa {'ppa:git-core/ppa': package_manage => true}
class{'::git': require => [Apt::Ppa['ppa:git-core/ppa'], Class['apt::update']]}

# Install PIP and AWS CLI
package {['pip', 'awscli']:
  ensure   => present,
  provider => 'pip',
  require  => Package['python-pip'],
}

# Hiera config
class {'::hiera':
  hierarchy => [
    '"nodes/%{::trusted.certname}"',
    '"%{::trusted.domainname}/%{::trusted.hostname}"',
    '"roles/%{role}"',
    'common',
  ],
  datadir   => '"%{environmentpath}/%{environment}/data"',
  owner     => 'root',
  group     => 'root',
}

# Install, configure and run R10K
class {'::r10k':
  sources  => {
    'main' => {
      'remote'  => 'https://github.com/vladgh/puppet.git',
      'basedir' => "${::settings::codedir}/environments",
      'prefix'  => false,
    },
  },
  cachedir => '/opt/puppetlabs/r10k/cache',
  postrun  => ['/bin/bash', '/etc/puppetlabs/r10k/postrun.sh'],
  provider => 'puppet_gem',
  version  => '2.1.1',
}
exec {'r10k deploy environment':
  command   => 'r10k deploy environment --puppetfile --verbose',
  path      => ['/opt/puppetlabs/puppet/bin'],
  logoutput => true,
  timeout   => 0,
  require   => Class['r10k::config'],
}
