require 'spec_helper_acceptance'

shared_examples 'profile::puppet::master' do
  describe file('/etc/puppetlabs/code/hiera.yaml') do
    it { should exist }
  end
  describe file('/etc/puppetlabs/r10k/r10k.yaml') do
    it { should exist }
  end
end
