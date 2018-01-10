# Rhea Role (VGH Puppet Master of Masters)
class role::rhea {
  include ::profile::base
  include ::profile::swap
  include ::profile::linuxfw
  include ::profile::fail2ban
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::monitor
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::puppet::agent
  include ::profile::puppet::master
  include ::profile::docker
}
