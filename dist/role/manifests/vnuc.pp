# VNuc Role (Intel NUC)
class role::vnuc {
  include ::profile::base
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::puppet::agent
  include ::profile::docker
}
