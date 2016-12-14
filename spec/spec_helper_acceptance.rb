require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

# Install puppet
run_puppet_install_helper

# Include shared examples
Dir['./spec/acceptance/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  dist_dir = File.join(proj_root, 'dist')
  modules_dir = File.join(proj_root, 'spec/fixtures/modules')
  hieradata_dir = File.join(proj_root, 'spec/fixtures/hieradata')
  production_dir = '/etc/puppetlabs/code/environments/production'

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # Fixes
      ## the second run (without provisioning) fails because
      ## /opt/puppetlabs is not in the path
      shell 'ln -fsn /root/.ssh/environment /etc/environment'
      ## A few packages that some modules assume are present on all distros
      if fact('osfamily') == 'Debian'
        # Make sure snake-oil certs are installed.
        apply_manifest_on(host, 'package { "ssl-cert": }')
        # Make sure rsyslog is installed
        apply_manifest_on(host, 'package { "rsyslog": }')
      end

      # Set-up environment
      scp_to(host, "#{proj_root}/environment.conf", production_dir)

      # Install hieradata
      scp_to(host, hieradata_dir, production_dir)

      # Install roles & profiles
      scp_to(host, dist_dir, production_dir)

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
    end
  end
end
