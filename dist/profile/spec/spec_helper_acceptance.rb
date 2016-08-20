require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Install puppet
run_puppet_install_helper

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |c|
  spec_dir = File.expand_path(File.dirname(__FILE__))
  profiles_root = File.expand_path(File.join(spec_dir, '..'))
  modules_dir = File.join(spec_dir, 'fixtures/modules')
  production_dir = '/etc/puppetlabs/code/environments/production'
  host_modules_dir = "#{production_dir}/modules"
  hieradata_dir = File.join(spec_dir, 'fixtures/hieradata')

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # Install hieradata
      scp_to(host, hieradata_dir, production_dir)

      # Install modules
      scp_to(
        host,
        modules_dir,
        production_dir,
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
          'log'
        ]
      )

      # Install profiles
      copy_module_to(
        host,
        source: profiles_root,
        target_module_path: host_modules_dir,
        module_name: 'profile'
      )
    end
  end
end
