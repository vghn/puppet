require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

unless ENV['RS_PROVISION'] == 'no' || ENV['BEAKER_provision'] == 'no'
  # Install puppet
  run_puppet_install_helper
end

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
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
        on host, 'ln -fsn /root/.ssh/environment /etc/environment'

        ## A few packages that some modules assume are present on all distros
        if fact('osfamily') == 'Debian'
          # Make sure required packages are installed.
          apply_manifest_on(host, 'package { ["ssl-cert", "rsyslog"]: }')
        end

        # Set-up environment
        env_file = File.join(proj_root, 'environment.conf')
        scp_to(host, env_file, production_dir)

        # Configure Hiera
        on host, <<~EOS
          rm /etc/puppetlabs/puppet/hiera.yaml || true
          mkdir -p /etc/puppetlabs/facter/facts.d
          echo 'role: #{host.name}' > /etc/puppetlabs/facter/facts.d/role.yaml
        EOS

        hiera_config = File.join(proj_root, 'spec/fixtures/hiera.yaml')
        scp_to(host, hiera_config, production_dir)

        # Install modules
        mod_dir = File.join(proj_root, 'spec/fixtures/modules'),
        scp_to(host, mod_dir, production_dir, ignore: PUPPET_MODULE_INSTALL_IGNORE)
      end

      # Install roles & profiles
      dist_dir = File.join(proj_root, 'dist')
      scp_to(host, dist_dir, production_dir)

      # Install Hiera Data
      hieradata_dir = File.join(proj_root, 'spec/fixtures/hieradata')
      scp_to(host, hieradata_dir, production_dir)
    end
  end
end
