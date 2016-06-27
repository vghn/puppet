# Base Profile
class profile::base {
  # Include essential classes
  include ::stdlib
  include ::apt
  include ::ntp
  include ::python
  include ::vg
  include ::vg::time

  # Ensure essential packages
  ensure_packages([
    'curl',
    'htop',
    'mysql-client',
    'nfs-common',
    'tmux',
    'unzip',
    'vim',
    'wget',
  ])
}
