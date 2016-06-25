# Puppet Master Class
class profile::puppet::master {
  # Upstart script for Rhea
  file { '/etc/init/rhea.conf' :
    ensure => file,
    source => 'puppet:///modules/profile/upstart-rhea.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
