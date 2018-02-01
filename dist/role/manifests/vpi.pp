# VPI Role (VGH Raspberry Pi)
class role::vpi {
  include ::profile::base
  include ::profile::swap
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::puppet::agent
  include ::profile::docker
}
