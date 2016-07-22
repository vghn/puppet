# Base Profile
class profile::base {
  # Include essential classes
  include ::stdlib
  if $::osfamily == 'Debian' { include ::apt }
  include ::ntp
  include ::vg
  include ::vg::time
  include ::sudo
  include ::sudo::configs
}
