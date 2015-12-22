# Zeus Role (VGH AWS On-Demand Instances)
class role::zeus {
  include ::profile::base
  include ::profile::ec2
  include ::profile::docker
  include ::profile::puppet::master
}
