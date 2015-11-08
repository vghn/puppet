require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  fixture_modules = File.join(proj_root, 'spec', 'fixtures', 'modules')

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # copies all the fixtures over
      scp_to host,
             fixture_modules,
             '/etc/puppetlabs/code',
             ignore: [
               '.bundle',
               '.git',
               '.idea',
               '.vagrant',
               '.vendor',
               'vendor',
               'acceptance',
               'bundle',
               'spec',
               'tests',
               'log',
               '.',
               '..'
             ]

      # Install this module, this is required because symlinks are not
      # transferred in the step above
      copy_module_to host, source: proj_root, module_name: 'profile'
    end
  end
end
