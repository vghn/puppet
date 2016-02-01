# McQueen Role (ANS AWS On-Demand Instances)
class role::mcqueen {
  include ::profile::base
  include ::profile::ec2
  include ::profile::docker
}
