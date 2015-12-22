require 'spec_helper_acceptance'

describe 'ROLE: HERA', node: :hera do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::profile::base
      include ::profile::docker
      include ::profile::ec2
      include ::profile::puppet::master
EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

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
  virtual = command('/opt/puppetlabs/bin/facter virtual').stdout.chomp
  describe package('docker-engine'), if: virtual != 'docker' do
    it { is_expected.to be_installed }
  end
  describe package('curl') do
    it { is_expected.to be_installed }
  end
  describe package('nfs-common') do
    it { is_expected.to be_installed }
  end
  describe package('mysql-client') do
    it { is_expected.to be_installed }
  end
  describe package('ruby2.0'), if: os[:family] == 'ubuntu' do
    it { is_expected.to be_installed }
  end
  describe package('gdebi-core'), if: os[:family] == 'ubuntu' do
    it { is_expected.to be_installed }
  end
  describe package('python-pip') do
    it { is_expected.to be_installed }
  end
  describe package('aws-cfn-bootstrap') do
    it { is_expected.to be_installed.by(:pip) }
  end
  describe file('/tmp/codedeploy-agent_all.deb'), if: os[:family] == 'ubuntu' do
    it { is_expected.to exist }
  end
  describe package('codedeploy-agent'), if: os[:family] == 'ubuntu' do
    it { is_expected.to be_installed }
  end
  describe service('codedeploy-agent'), if: os[:family] == 'ubuntu' do
    it { is_expected.to be_running }
  end
end
