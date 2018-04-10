# Zucu Role (VGH Dell)
class role::zucu {
  include ::profile::base
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::monitor
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::puppet::agent
  include ::profile::docker
}
