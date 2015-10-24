# Base Profile
class profile::base {
  # Disable Puppet services
  service {['puppet', 'mcollective']:
    ensure => stopped,
    enable => false,
  }

  # Include classes
  hiera_include('classes', [])

  # SSH Keys
  if (::ec2_metadata) {
    if ($::os['name'] == 'Ubuntu') {
      $user = 'ubuntu'
    } else {
      $user = 'root'
    }
  } else {
    $user = 'root'
  }
  $authorized_keys = hiera_hash('authorized_keys', undef)
  if ($authorized_keys) {
    create_resources(
      'ssh_authorized_key',
      $authorized_keys,
      { user => $user }
    )
  }
}
