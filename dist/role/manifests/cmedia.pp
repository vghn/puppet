# Cosmin's Media Role
class role::cmedia {
  include ::profile::base
  include ::profile::fail2ban
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::git
  include ::profile::puppet::agent
  include ::profile::docker
}
