# Samba Profile
class profile::samba {
  # Create SambaShare group
  group { 'sambashare':
    ensure  => present,
    members => ['root'],
  }

  # Create shares
  $samba_shares = lookup({
    'name'          => 'samba::server::shares',
    'default_value' => {}
  })

  $samba_paths = $samba_shares.map |$share_name,$share_options| {
    $options  = $share_options # Fix for something similar to https://github.com/rodjek/puppet-lint/issues/450
    $filtered = $options.filter |$option| { $option =~ /^path = / }
    regsubst($filtered,'^(.+) = (.+)$','\2')
  }

  $samba_paths.flatten.each |Stdlib::Absolutepath $share_path| {
    profile::mkdir_p { $share_path: }
    -> file { $share_path :
      ensure  => directory,
      group   => 'sambashare',
      mode    => '0775',
      require => Group['sambashare'],
    }
  }

  # Install and configure Samba server
  include ::samba::server
}
