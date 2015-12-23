require 'spec_helper_acceptance'

shared_examples 'profile::docker' do
  virtual = command('/opt/puppetlabs/bin/facter virtual').stdout.chomp
  describe package('docker-engine') do
    if virtual != 'docker'
      it { is_expected.to be_installed }
    else
      it { is_expected.not_to be_installed }
    end
  end
end
