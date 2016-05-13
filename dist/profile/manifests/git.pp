# GIT Profile
class profile::git {
  # Latest GIT
  include ::apt
  apt::ppa {'ppa:git-core/ppa': package_manage => true}
  class {'::git':
    require => [
      Apt::Ppa['ppa:git-core/ppa'],
      Class['apt::update'],
      ],
  }
}
