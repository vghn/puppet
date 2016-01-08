# AMI Profile
class profile::vm {
  include ::profile::base

  # Ensure essential packages
  ensure_packages([
    'tmux',
  ])
  
  # Distro dependent packages
  case $::os['name'] {
    'Ubuntu': {
      ensure_packages([
        'vim-gnome',
      ])
    }
    default: {
      ensure_packages([
        'vim',
      ])
    }
  }
}
