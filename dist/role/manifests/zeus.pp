# Zeus Role (VGH AWS On-Demand Instances)
class role::zeus {
  include ::profile::base
  include ::profile::swap
  include ::profile::git
  include ::profile::jq
  include ::profile::puppet::agent
  include ::profile::puppet::master
  include ::profile::aws::cloudformation
  include ::profile::aws::ssm
  include ::profile::aws::s3fs
  include ::profile::docker
  include ::profile::rvm
}
