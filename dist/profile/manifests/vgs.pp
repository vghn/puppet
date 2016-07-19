# SWAP Class
class profile::vgs {
  vcsrepo { 'VGS Library':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/vghn/vgs.git',
    path     => '/opt/vgs',
    revision => 'master',
    require  => Package['git'],
  }
}
