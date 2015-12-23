require 'spec_helper_acceptance'

shared_examples 'profile::base' do
  describe user('root') do
    it { should have_authorized_key 'ssh-rsa ABC test-key' }
  end
  describe service('ntp') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
