# VPI Role (VGH Raspberry Pi)
class role::vpi {
  include ::profile::base
  include ::profile::swap
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::python
  include ::profile::jq
  include ::profile::puppet::agent
}
