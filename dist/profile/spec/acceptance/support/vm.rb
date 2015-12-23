require 'spec_helper_acceptance'

shared_examples 'profile::vm' do
  describe package('vim') do
    it { is_expected.to be_installed }
  end
  describe package('tmux') do
    it { is_expected.to be_installed }
  end
end
