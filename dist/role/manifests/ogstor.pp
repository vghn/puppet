# OGStore Role (Cosmin's Storage)
class role::ogstor {
  include ::profile::base
  include ::profile::log
  include ::profile::git
  include ::profile::puppet::agent
  include ::profile::docker
  include ::profile::samba
}
