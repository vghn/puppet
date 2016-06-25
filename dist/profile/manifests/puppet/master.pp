# Puppet Master Class
class profile::puppet::master {
  # Upstart script for Rhea
  file { '/etc/init/rhea.conf' :
    ensure => file,
    source => 'puppet:///modules/profile/rhea/upstart-rhea.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Backup cron job
  cron { 'Backup' :
    ensure  => present,
    command => 'docker run --rm -it -v $(pwd):/vpm --volumes-from puppet_data_1 vladgh/awscli:latest /vpm/bin/backup',
    minute  => '33',
    user    => 'root',
  }
}
