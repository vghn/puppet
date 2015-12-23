require 'spec_helper_acceptance'

shared_examples 'profile::ec2' do
  describe package('curl') do
    it { is_expected.to be_installed }
  end
  describe package('nfs-common') do
    it { is_expected.to be_installed }
  end
  describe package('mysql-client') do
    it { is_expected.to be_installed }
  end
  describe package('ruby2.0') do
    it { is_expected.to be_installed }
  end
  describe package('gdebi-core') do
    it { is_expected.to be_installed }
  end
  describe package('python-pip') do
    it { is_expected.to be_installed }
  end
  release = command('/usr/bin/lsb_release -cs').stdout.chomp
  describe file("/etc/apt/sources.list.d/git-core-ppa-#{release}.list") do
    it { should exist }
  end
  describe package('git') do
    it { is_expected.to be_installed }
  end
  describe package('awscli') do
    it { is_expected.to be_installed.by(:pip) }
  end
  describe package('aws-cfn-bootstrap') do
    it { is_expected.to be_installed.by(:pip) }
  end
  describe package('codedeploy-agent') do
    it { is_expected.to be_installed }
  end
  describe service('codedeploy-agent') do
    it { is_expected.to be_running }
  end
end
