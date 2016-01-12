require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

# Install Puppet
run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  target_dir = '/etc/puppetlabs/code/modules'

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # p host.puppet; abort
      # Install this module
      shell "rm -r #{target_dir}/profile",
            accept_all_exit_codes: true
      copy_module_to(
        host,
        source: proj_root,
        target_module_path: target_dir,
        module_name: 'profile'
      )
    end
  end
end
