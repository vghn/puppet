# Dotfiles Class
class profile::dotfiles (
  Optional[String] $repo = 'https://github.com/vladgh/dotfiles',
  Optional[String] $path = '/opt/dotfiles',
){
  include ::profile::vgs

  vcsrepo { 'DotFiles Vlad':
    ensure   => latest,
    provider => git,
    source   => $repo,
    path     => $path,
    revision => 'master',
    require  => [
      Vcsrepo['VGS Library'],
      Package['git'],
    ],
  }
}
