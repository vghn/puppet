# AWS Simple Systems Manager Profile
class profile::aws::ssm {
  # AWS Simple Systems Manager Agent
  wget::fetch {'AWS SSM Agent Deb':
    source      => 'https://amazon-ssm-us-east-1.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb',
    destination => '/usr/local/src/amazon-ssm-agent.deb',
  }

  package {'AWS SSM Agent':
    ensure   => present,
    name     => 'amazon-ssm-agent',
    source   => '/usr/local/src/amazon-ssm-agent.deb',
    provider => dpkg,
    require  => [
      Wget::Fetch['AWS SSM Agent Deb'],
    ],
  }

  service {'AWS SSM Agent':
    ensure  => running,
    enable  => true,
    name    => 'amazon-ssm-agent',
    require => Package['AWS SSM Agent'],
  }
}
