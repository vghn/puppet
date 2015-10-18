# Bootstrap manifest
notice("Bootstraping ${role}")

# Essential packages
ensure_packages ([
  'curl',
  'python-pip',
  'software-properties-common'
])

# Include classes
include apt

# Install latest GIT
apt::ppa {'ppa:git-core/ppa': require => Package['software-properties-common']}
class{'git': require => Apt::Ppa['ppa:git-core/ppa']}

# Install PIP and AWS CLI
package {'awscli':
  ensure   => present,
  provider => pip,
  require  => Package['python-pip'],
}

# Hiera config
class {'hiera':
  hierarchy => [
    '%{trusted.certname}',
    '%{role}',
    'common',
  ],
  datadir   => '"%{environmentpath}/%{environment}/data"',
  owner     => 'root',
  group     => 'root',
}

# Install and configure R10K
# FIXME: Temporary fix until a new version of r10k (this is already in master)
file {'/etc/puppetlabs/r10k':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}
class {'r10k':
  sources  => {
    'main' => {
      'remote'  => 'https://github.com/vladgh/puppet.git',
      'basedir' => "${::settings::codedir}/environments",
    },
  },
  postrun  => ['/bin/bash', '/etc/puppetlabs/r10k/postrun.sh'],
  provider => 'puppet_gem',
  version  => '2.0.3',
  require  => [
    File['/etc/puppetlabs/r10k']
  ],
}

