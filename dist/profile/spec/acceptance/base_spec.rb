require 'spec_helper_acceptance'

shared_examples 'profile::base' do
  # Using puppet_apply as a helper
  describe service('puppet') do
    it { is_expected.not_to be_running }
  end
  describe service('mcollective') do
    it { is_expected.not_to be_running }
  end
  describe service('ntp') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
  describe user('root') do
    it { should have_authorized_key 'ssh-rsa ABC test-key' }
  end
end

describe 'profile::base' do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      class { '::profile::base': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  include_examples 'profile::base'
end
