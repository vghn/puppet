require 'puppet'
require 'beaker-puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'

# VARs
TEST_CLASS = ENV['BEAKER_class'] || 'role::none'

# Install puppet
unless ENV['RS_PROVISION'] == 'no' || ENV['BEAKER_provision'] == 'no'
  run_puppet_install_helper
  configure_type_defaults_on(hosts)
end

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  # Paths
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  production_dir = '/etc/puppetlabs/code/environments/production'

  # Readable test descriptions
  config.formatter = :documentation

  # Configure all nodes in nodeset
  config.before :suite do
    hosts.each do |host|
      # Prepare host
      unless ENV['RS_PROVISION'] == 'no' || ENV['BEAKER_provision'] == 'no'
        #FIXME https://www.rubydoc.info/github/puppetlabs/beaker/Beaker%2FHostPrebuiltSteps%3Aset_env

        # Configure role
        shell <<-EOS
          mkdir -p /etc/puppetlabs/facter/facts.d
          echo 'role: #{host.name}' > /etc/puppetlabs/facter/facts.d/role.yaml
        EOS

        # Set-up environment
        env_file = File.join(proj_root, 'environment.conf')
        scp_to host, env_file, production_dir

        # Configure Hiera
        shell <<-EOS
          rm -f /etc/puppetlabs/puppet/hiera.yaml
          rm -fr /etc/puppetlabs/puppet/hieradata
        EOS
        hiera_config = File.join(proj_root, 'spec/fixtures/hiera.yaml')
        scp_to host, hiera_config, production_dir
      end
    end
  end
end
