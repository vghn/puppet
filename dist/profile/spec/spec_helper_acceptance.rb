require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Include shared examples
Dir["./spec/acceptance/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  modules_dir = File.join(proj_root, 'spec', 'fixtures', 'modules')
  hiera_dir = File.join(proj_root, 'spec', 'fixtures', 'hieradata')
  hiera_host_dir = '/etc/puppetlabs/code/environments/production'

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # SCP modules folder (this excludes stuff like spec and test folders)
      modules = Dir["#{modules_dir}/*/"].map do |mod|
        File.basename(mod)
      end
      modules.each do |module_name|
        module_dir = "#{modules_dir}/#{module_name}"
        copy_module_to(
          host,
          source: module_dir,
          module_name: module_name
        )
      end

      # Install this module, this is required because symlinks are not
      # transferred in the step above
      copy_module_to host, source: proj_root, module_name: 'profile'

      # Include Hiera data
      shell "mkdir -p #{hiera_host_dir}"
      scp_to host, hiera_dir, hiera_host_dir
    end
  end
end
