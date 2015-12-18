# Base Profile
class profile::base {
  # Include classes
  include ::stdlib
  include ::apt
  include ::ntp

  # SSH Keys
  if ($::ec2_metadata) {
    if ($::os['name'] == 'Ubuntu') {
      $user = 'ubuntu'
    } else {
      $user = 'root'
    }
  } else {
    $user = 'root'
  }
  $ssh_authorized_keys = hiera_hash('ssh_authorized_keys', undef)
  if ($ssh_authorized_keys != undef) {
    create_resources(
      'ssh_authorized_key',
      $ssh_authorized_keys,
      { user => $user }
    )
  }
}
