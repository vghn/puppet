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
    '"%{trusted.certname}"',
    '"roles/%{role}.private"',
    '"roles/%{role}"',
    '"env/%{environment}"',
    'common',
  ],
  datadir   => '"%{environmentpath}/%{environment}/data"',
  owner     => 'root',
  group     => 'root',
}

# Install and configure R10K
# FIXME: Temporary fix until R10K module > 3.1.1 (this is already in master)
file {'/etc/puppetlabs/r10k':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}
class {'::r10k':
  sources => {
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
  require  => [
    File['/etc/puppetlabs/r10k']
  ],
}

