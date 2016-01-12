require 'spec_helper_acceptance'

shared_examples 'profile::puppet::agent' do
  describe service('puppet') do
    it { is_expected.not_to be_running }
  end
  describe service('mcollective') do
    it { is_expected.not_to be_running }
  end
  describe service('pxp-agent') do
    it { is_expected.not_to be_running }
  end
end
