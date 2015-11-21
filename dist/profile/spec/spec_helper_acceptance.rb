require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  fixture_modules_dir = File.join(proj_root, 'spec', 'fixtures', 'modules')

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # SCP modules folder (this excludes stuff like spec and test folders)
      fixture_modules = Dir["#{fixture_modules_dir}/*/"].map do |mod|
        File.basename(mod)
      end
      fixture_modules.each do |module_name|
        module_dir = "#{fixture_modules_dir}/#{module_name}"
        copy_module_to(
          host,
          source: module_dir,
          module_name: module_name
        )
      end

      # Install this module, this is required because symlinks are not
      # transferred in the step above
      copy_module_to host, source: proj_root, module_name: 'profile'
    end
  end
end
