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
    version       => '0.16.0',
    extra_options => "--collector.textfile.directory=${textfile_directory} --collector.filesystem.ignored-mount-points=\\'^/(var/lib/docker|run/docker)($|/)\\'"
  }
}
