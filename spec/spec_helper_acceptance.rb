require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Install puppet
run_puppet_install_helper

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
      # Fixes
      ## the second run (without provisioning) fails because
      ## /opt/puppetlabs is not in the path
      shell 'ln -fsn /root/.ssh/environment /etc/environment'
      ## A few packages that some modules assume are present on all distros
      if fact('osfamily') == 'Debian'
        # Make sure required packages are installed.
        apply_manifest_on(host, 'package { ["ssl-cert", "rsyslog"]: }')
      end

      # Set-up environment
      scp_to(host, File.join(proj_root, 'environment.conf'), production_dir)

      # Install hieradata
      shell 'rm /etc/puppetlabs/puppet/hiera.yaml || true'
      scp_to(
        host,
        File.join(proj_root, 'spec/fixtures/hiera.yaml'),
        production_dir
      )
      scp_to(
        host,
        File.join(proj_root, 'spec/fixtures/hieradata'),
        production_dir
      )

      # Install roles & profiles
      scp_to(host, File.join(proj_root, 'dist'), production_dir)

      # Install modules
      scp_to(
        host,
        File.join(proj_root, 'spec/fixtures/modules'),
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
    end
  end
end
