# AWS Simple Systems Manager Profile
class profile::aws::s3fs {
  $assets_bucket = hiera('assets_bucket', undef)
  $iam_instance_role = hiera('iam_instance_role', undef)

  if $iam_instance_role {
    $s3fs_mount_options = "_netdev,allow_other,use_rrs,use_cache=/tmp,iam_role=${iam_instance_role}"
  } else {
    $s3fs_mount_options = '_netdev,allow_other,use_rrs,use_cache=/tmp'
  }

  ensure_packages([
    'libcurl4-gnutls-dev',
    'libfuse-dev',
    'libssl-dev',
    'libxml2-dev',
  ])

  wget::fetch {'S3FS-Fuse Deb':
    source      => 'https://s3.amazonaws.com/vladgh/debs/s3fs-fuse.deb',
    destination => '/usr/local/src/s3fs-fuse.deb',
  }
  package {'S3FS-Fuse':
    ensure   => present,
    name     => 's3fs-fuse',
    source   => '/usr/local/src/s3fs-fuse.deb',
    provider => dpkg,
    require  => [
      Wget::Fetch['S3FS-Fuse Deb'],
      Package[
        'libcurl4-gnutls-dev',
        'libfuse-dev',
        'libssl-dev',
        'libxml2-dev',
      ]
    ],
  }

  if $assets_bucket {
    file {"/mnt/s3_${assets_bucket}":
      ensure => 'directory',
    } ->
    mount {'Mount assets bucket':
      ensure  => present,
      name    => "/mnt/s3_${assets_bucket}",
      atboot  => true,
      device  => "s3fs#${assets_bucket}",
      fstype  => 'fuse',
      options => $s3fs_mount_options,
      require => Package['S3FS-Fuse'],
    }
  }
}
