# Monitor Class
class profile::monitor (
  String $textfile_directory = '/var/lib/prometheus_node_exporter'
){
  # Ensure directory
  file { $textfile_directory:
      ensure  => directory,
      mode    => '0770',
      owner   => 'node-exporter',
      group   => 'node-exporter',
      require => Class['prometheus::node_exporter'],
  }

  # Node exporter class
  class { 'prometheus::node_exporter':
    version       => '0.15.2',
    extra_options => "--collector.textfile.directory ${textfile_directory} --collector.filesystem.ignored-mount-points \"^/(sys|proc|dev|host|etc|rootfs/var/lib/docker/containers|rootfs/var/lib/docker/overlay2|rootfs/run/docker/netns|rootfs/var/lib/docker/aufs)($$|/)\""
  }
}
