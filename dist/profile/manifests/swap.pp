# SWAP Class
class profile::swap(
  String $swapfile = '/var/swap.space',
  Integer $swapfile_size_mb = 1024,
) {

  exec {'Create swap file':
    command => "/bin/dd if=/dev/zero of=${swapfile} bs=1M count=${swapfile_size_mb}",
    creates => $swapfile,
  }
  exec {'Attach swap file':
    command => "/sbin/mkswap ${swapfile} && /sbin/swapon ${swapfile}",
    require => Exec['Create swap file'],
    unless  => "/sbin/swapon -s | grep ${swapfile}",
  }
  mount {'swap':
    ensure  => present,
    fstype  => swap,
    device  => $swapfile,
    dump    => 0,
    pass    => 0,
    require => Exec['Attach swap file'],
  }
}
