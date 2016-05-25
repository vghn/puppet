# AWS Simple Systems Manager Profile
class profile::aws::s3fs {
  ensure_packages([
    'libcurl4-gnutls-dev',
    'libfuse-dev',
    'libssl-dev',
    'libxml2-dev',
  ])

  wget::fetch {'S3FS-Fuse Deb':
    source      => 'https://s3.amazonaws.com/vladgh/packages/s3fs-fuse.deb',
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
}
