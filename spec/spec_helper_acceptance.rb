require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# VARs
ROLE = ENV['BEAKER_role'] || 'none'

# Install puppet
unless ENV['RS_PROVISION'] == 'no' || ENV['BEAKER_provision'] == 'no'
  run_puppet_install_helper
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
        # Fixes environment
        ## the second run (without provisioning) fails because
        ## /opt/puppetlabs is not in the path
        shell 'ln -fsn /root/.ssh/environment /etc/environment'

        ## A few packages that some modules assume are present on all distros
        if fact('osfamily') == 'Debian'
          # Make sure required packages are installed.
          apply_manifest_on(host, 'package { ["ssl-cert", "rsyslog"]: }')
        end

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
