# AMI Profile
class profile::vm {
  include ::profile::base

  # Ensure essential packages
  ensure_packages([
    'vim',
  ])
}

