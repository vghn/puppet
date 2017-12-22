# Prometheus Role (VGH Monitoring)
class role::prometheus {
  include ::profile::base
  include ::profile::swap
  include ::profile::fail2ban
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::monitor
  include ::profile::python
  include ::profile::git
  include ::profile::jq
  include ::profile::vgs
  include ::profile::puppet::agent
  include ::profile::docker
}
