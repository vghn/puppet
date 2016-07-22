# Mini Role (Vlad's Media Server)
class role::mini {
  include ::profile::base
  include ::profile::vgs
  include ::profile::puppet::agent
}
