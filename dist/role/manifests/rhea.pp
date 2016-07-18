# Rhea Role (VGH Puppet Master of Masters)
class role::rhea {
  include ::profile::base
  include ::profile::swap
  include ::profile::log
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::puppet::master
  include ::profile::puppet::agent
  include ::profile::aws::cloudformation
  include ::profile::aws::ssm
  include ::profile::docker
}
