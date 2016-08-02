require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'with a perpetual docker container'

  describe package('git') do
    it { is_expected.to be_installed }
  end

  describe package('awscli') do
    it { is_expected.to be_installed.by('pip') }
  end

  describe package('r10k') do
    it { is_expected.to be_installed.by('gem') }
  end

  describe file('/etc/puppetlabs/r10k/r10k.yaml') do
    it { is_expected.to exist }
  end

  describe command('aws --version') do
    its(:stderr) { is_expected.to contain('aws-cli') }
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('git version') do
    its(:stdout) { is_expected.to contain('git') }
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('r10k version') do
    its(:stdout) { is_expected.to contain('r10k') }
    its(:exit_status) { is_expected.to eq 0 }
  end
end
