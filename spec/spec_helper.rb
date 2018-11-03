# Global RSpec configuration
RSpec.configure do |config|
  config.tty = true
  config.color = true
  config.fail_fast = true
  config.formatter = :documentation
  config.after(:suite) { RSpec::Puppet::Coverage.report!(95) }
  config.mock_with :rspec
end

require 'puppetlabs_spec_helper/module_spec_helper'

require 'rspec-puppet-facts'
include RspecPuppetFacts

fixtures_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

# RSpec configuration
RSpec.configure do |config|
  config.trusted_node_data = true
  config.module_path = File.join(fixtures_path, 'modules/dist') + ':' +
                       File.join(fixtures_path, 'modules/r10k')
  config.manifest_dir = File.join(fixtures_path, 'manifests')
  config.hiera_config = File.join(fixtures_path, 'hiera.yaml')
end
