# Monitor Class
class profile::monitor {
  # Node exporter class
  class { 'prometheus::node_exporter':
    version => '0.15.2',
  }
}
