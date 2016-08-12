# Rhea Role (VGH Puppet Master of Masters)
class role::rhea {
  include ::profile::base
  include ::profile::linuxfw
  include ::profile::log
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::vgs
  include ::profile::puppet::master
  include ::profile::puppet::agent
  include ::profile::docker
}
