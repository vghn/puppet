# Base Profile
class profile::base {
  # Include essential classes
  include ::stdlib
  include ::apt
  include ::ntp
  include ::python
  include ::vg
  include ::vg::time
}
