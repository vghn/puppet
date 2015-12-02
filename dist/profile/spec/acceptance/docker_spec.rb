require 'spec_helper_acceptance'

describe 'profile::docker' do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      class { '::profile::docker': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  include_examples 'profile::base'

  virtual = command('/opt/puppetlabs/bin/facter virtual').stdout.chomp
  describe package('docker-engine'), :if => virtual != 'docker' do
    it { is_expected.to be_installed }
  end
end
