# GIT Profile
class profile::git(Optional[Boolean] $system = false) {
  if $system {
    ensure_packages(['git'])
  } else {
    # Latest GIT
    require ::apt
    apt::ppa { 'ppa:git-core/ppa': package_manage => true }
    class { '::git' :
      package_ensure => 'latest',
      require        => [
        Apt::Ppa['ppa:git-core/ppa'],
        Class['apt::update'],
        ],
    }
  }
}
