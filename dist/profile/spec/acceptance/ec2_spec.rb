require 'spec_helper_acceptance'

describe 'profile::ec2' do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      class { '::profile::ec2': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  include_examples 'profile::base'

  describe package('nfs-common') do
    it { should be_installed }
  end
  describe package('mysql-client') do
    it { should be_installed }
  end
  describe package('ruby2.0'), if: os[:family] == 'ubuntu' do
    it { should be_installed }
  end
  describe package('gdebi-core'), if: os[:family] == 'ubuntu' do
    it { should be_installed }
  end
  describe package('python-pip') do
    it { should be_installed }
  end
  describe command('/opt/puppetlabs/puppet/bin/gem list') do
    its(:stdout) { should contain('aws-sdk') }
  end
  describe package('aws-cfn-bootstrap') do
    it { should be_installed.by(:pip) }
  end
  describe file('/tmp/codedeploy-agent_all.deb'), if: os[:family] == 'ubuntu' do
    it { should exist }
  end
  describe package('codedeploy-agent'), if: os[:family] == 'ubuntu' do
    it { should be_installed }
  end
  describe service('codedeploy-agent'), if: os[:family] == 'ubuntu' do
    it { should be_running }
  end
end
