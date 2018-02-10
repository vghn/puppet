# Monitor Class
class profile::monitor (
  Optional[String] $collector_directory = '/var/lib/node_exporter/textfile_collector'
){
  # Make sure directory exists

  # Node exporter class
  profile::mkdir_p { $collector_directory: }
  -> class { 'prometheus::node_exporter':
    version       => '0.15.2',
    extra_options => "--collector.textfile.directory ${collector_directory}"
  }
}
