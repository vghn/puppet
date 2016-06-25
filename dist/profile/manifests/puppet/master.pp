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
    command => "bash -c 'docker run --rm --name backup --hostname backup -v /opt/vpm/puppet:/vpm --volumes-from puppet_data_1 vladgh/awscli:latest /vpm/bin/backup'",
    minute  => '33',
    hour    => '*/3',
    user    => 'root',
  }
}
