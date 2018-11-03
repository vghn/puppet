# Nebula Role (Cosmin's NAS)
class role::nebula {
  include ::profile::base
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::puppet::agent
  include ::profile::samba
}
