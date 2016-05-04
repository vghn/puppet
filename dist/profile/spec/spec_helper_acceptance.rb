require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Install puppet
run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |c|
  spec_dir = File.expand_path(File.dirname(__FILE__))
  profiles_root = File.expand_path(File.join(spec_dir, '..'))
  modules_dir = File.join(spec_dir, 'fixtures/modules')
  host_modules_dir = '/etc/puppetlabs/code/environments/production/modules'
  hieradata_dir = File.join(spec_dir, 'fixtures/hieradata')
  host_hieradata_dir = '/etc/puppetlabs/code/environments/production/hieradata'

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # Install pip
      if fact('operatingsystem') == 'Ubuntu' &&
         fact('lsbdistcodename') == 'trusty' &&
         ENV['BEAKER_provision'] != 'no'
        # Install PIP and upgrade it
        # Fix https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991
        install_package(host, 'python-pip')
        on(host, 'sudo pip install --upgrade pip setuptools')
      end

      # Install hieradata
      rsync_to(host, hieradata_dir, host_hieradata_dir)

      # Install modules
      rsync_to(host, modules_dir, host_modules_dir)

      # Install profiles
      shell "rm -r #{host_modules_dir}/profile", accept_all_exit_codes: true
      copy_module_to(
        host,
        source: profiles_root,
        target_module_path: host_modules_dir,
        module_name: 'profile'
      )
    end
  end
end
