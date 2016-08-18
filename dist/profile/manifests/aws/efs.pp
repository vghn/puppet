# AWS Elastic File Storage Class
class profile::aws::efs (
  Optional[String] $mount_target = undef,
  Optional[String] $mount_point = undef,
) {
  if $mount_target {
    case $::osfamily {
      'Debian': {
        ensure_packages(['nfs-common'])
      }
      default: {
        fail("The ${module_name} module is not supported on an ${::osfamily} distribution.")
      }
    }

    profile::mkdir_p { $mount_point: } ->
    mount { $mount_point:
      ensure  => present,
      device  => $mount_target,
      fstype  => 'nfs4',
      options => 'defaults,vers=4.1',
      dump    => 0,
      pass    => 0,
      require => Package['nfs-common'],
    }
  }
}
