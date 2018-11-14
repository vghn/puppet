# GIT Profile
class profile::git(Optional[Boolean] $system = false) {
  if $system {
    ensure_packages(['git'])
  } else {
    # Latest GIT
    apt::ppa { 'ppa:git-core/ppa': }
    class { '::git' :
      package_ensure => 'latest',
    }
  }
}
