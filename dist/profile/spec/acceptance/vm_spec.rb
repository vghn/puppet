require 'spec_helper_acceptance'

describe 'profile::vm' do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      class { '::profile::vm': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  include_examples 'profile::base'
  describe package('vim') do
    it { should be_installed }
  end
end
