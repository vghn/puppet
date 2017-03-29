# Miscellaneous Profile
class profile::misc(
  Boolean $ignore_lid_switch = false,
) {
  # Do nothing when closing the lid on a laptop
  if $ignore_lid_switch {
    ini_setting { 'Ignore LID close':
      ensure  => present,
      path    => '/etc/systemd/logind.conf',
      section => 'Login',
      setting => 'HandleLidSwitch',
      value   => 'ignore',
    }
    ~> service { 'systemd-logind' :
      ensure => running,
      enable => true,
    }
  }
}
