# Bootstrap manifest
notice("Bootstraping ${role}")

# Include classes
include apt

# Install PIP and AWS CLI
package {'awscli':
  ensure   => present,
  provider => pip,
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

# Install latest GIT
apt::ppa {'ppa:git-core/ppa':}

# Install and configure R10K
# FIXME: Temporary fix until a new version of r10k (this is already in master)
file {'/etc/puppetlabs/r10k':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}
class { 'r10k':
  sources  => {
    'main' => {
      'remote'  => 'https://github.com/vladgh/puppet.git',
      'basedir' => "${::settings::codedir}/environments",
    },
  },
  postrun  => ['/bin/bash', '/etc/puppetlabs/r10k/postrun.sh'],
  provider => 'puppet_gem',
  version  => '2.0.3',
  require  => File['/etc/puppetlabs/r10k'],
}

