require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'with a docker image'

  describe package('git') do
    it { is_expected.to be_installed }
  end

  describe package('awscli') do
    it { is_expected.to be_installed.by('pip') }
  end

  describe package('r10k') do
    it { is_expected.to be_installed.by('gem') }
  end

  describe command('aws --version') do
    its(:stderr) { should contain('aws-cli') }
  end

  describe command('git version') do
    its(:stdout) { should contain('git') }
  end

  describe command('r10k version') do
    its(:stdout) { should contain('r10k') }
  end

  describe file('/etc/puppetlabs/r10k/r10k.yaml') do
    it { should exist }
  end
end
