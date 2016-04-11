require 'spec_helper_acceptance'

shared_examples 'profile::puppet::master' do
  describe file('/etc/puppetlabs/code/hiera.yaml') do
    it { is_expected.to exist }
  end
  describe file('/etc/puppetlabs/r10k/r10k.yaml') do
    it { is_expected.to exist }
  end
  describe file('/usr/local/bin/puppet_vgh_master_update') do
    it { is_expected.to exist }
    it { should be_owned_by 'root' }
    it { should be_executable.by_user('root') }
  end
  describe file('/etc/puppetlabs/code/environments/production/Puppetfile') do
    it { is_expected.to exist }
  end
end
