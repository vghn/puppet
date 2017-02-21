# Green Role (Cosmin's Linode Green.ShirtAve.com)
class role::green {
  include ::profile::base
  include ::profile::linuxfw
  include ::profile::fail2ban
  include ::profile::log
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::vgs
  include ::profile::puppet::agent
  include ::profile::docker
}
