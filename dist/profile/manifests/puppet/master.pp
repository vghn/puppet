# Puppet Master Class
class profile::puppet::master {
  # Hiera config
  $hiera_data_dir = "${::settings::environmentpath}/%{::environment}/hieradata"
  class {'::hiera':
    datadir            => $hiera_data_dir,
    hiera_yaml         => "${::settings::codedir}/hiera.yaml",
    puppet_conf_manage => false,
    create_symlink     => false,
    owner              => 'root',
    group              => 'root',
    hierarchy          => [
      'nodes/%{::trusted.certname}',
      '%{::trusted.domainname}/%{::trusted.hostname}',
      'roles/%{::trusted.extensions.pp_role}',
      'roles/%{role}',
      'projects/%{::trusted.extensions.pp_project}',
      'projects/%{::project}',
      'virtual/%{::virtual}',
      'osfamily/%{::osfamily}',
      'private',
      'common',
    ],
  }

  # Install, configure and run R10K
  $control_repo = hiera('control_repo')
  $r10k_version = hiera('r10k_version', 'latest')
  class {'::r10k':
    sources  => {
      'main' => {
        'remote'  => $control_repo,
        'basedir' => $::settings::environmentpath,
        'prefix'  => false,
      },
    },
    cachedir => '/opt/puppetlabs/r10k/cache',
    provider => 'puppet_gem',
    version  => $r10k_version,
    notify   => Exec['R10K deploy environment'],
  }

  # Deploy R10K environment
  exec {'R10K deploy environment':
    command   => '/opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose',
    creates   => "${::settings::environmentpath}/production/Puppetfile",
    logoutput => true,
    timeout   => 600,
    require   => Package['r10k'],
  }

  # Sync SSL Dir to AWS S3
  if ( $::ca_s3_path and $::aws_cfn_name ) {
    $ca_vpm_dir = '/opt/ca_vpm'
    include ::docker
    exec {'ca_vpm_dir':
      command => "/bin/mkdir -p ${ca_vpm_dir}",
      unless  => "/usr/bin/test -d ${ca_vpm_dir}",
    } ->
    docker::run {'ca-s3-sync':
      image         => 'vladgh/s3sync:latest',
      detach        => true,
      restart       => 'on-failure:10',
      volumes       => [
        "${ca_vpm_dir}:/watch",
      ],
      env           => [
        "S3PATH=${::ca_s3_path}",
      ],
      pull_on_start => true,
      require       => Service['docker'],
    }
  } else {
    docker::image {'vladgh/s3sync:latest': }
  }
}
