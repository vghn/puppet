# Mini Role (Vlad's Media Server)
class role::mini {
  include ::profile::base
  include ::profile::ca_certs
  include ::profile::log
  include ::profile::git
  include ::profile::puppet::agent
  include ::profile::docker_vgh
  include ::profile::samba
}
