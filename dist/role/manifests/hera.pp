# Hera Role (VGH AWS AMIs)
class role::hera {
  include ::profile::base
  include ::profile::ec2
  include ::profile::docker
  include ::profile::puppet::master
}
