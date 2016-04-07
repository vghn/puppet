require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  target_dir = '/etc/puppetlabs/code/modules'

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      unless ENV['BEAKER_provision'] == 'no'
        # Install Puppet
        install_puppet_agent_on(hosts)
        add_aio_defaults_on(hosts)
        add_puppet_paths_on(hosts)

        if fact('operatingsystem') == 'Ubuntu' &&
           fact('lsbdistcodename') == 'trusty'
          # Install PIP and upgrade it
          # Fix https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991
          install_package(host, 'python-pip')
          on(host, 'sudo pip install --upgrade pip setuptools awscli')
        end
      end

      # Install modules
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
