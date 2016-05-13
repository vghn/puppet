# AWS CodeDeploy Profile
class profile::aws::codedeploy {
  ensure_packages([
    'ruby2.0',
    'gdebi-core',
  ])
  wget::fetch {'CodeDeploy Deb':
    source      => 'https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/codedeploy-agent_all.deb',
    destination => '/usr/local/src/codedeploy-agent_all.deb',
  }
  package {'CodeDeploy Agent':
    ensure   => present,
    name     => 'codedeploy-agent',
    source   => '/usr/local/src/codedeploy-agent_all.deb',
    provider => dpkg,
    require  => [
      Wget::Fetch['CodeDeploy Deb'],
      Package['ruby2.0', 'gdebi-core']
    ],
  }
  service {'CodeDeploy Service':
    ensure  => running,
    enable  => true,
    name    => 'codedeploy-agent',
    require => Package['CodeDeploy Agent'],
  }
}
