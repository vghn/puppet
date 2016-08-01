require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'using alpine'
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

  describe file('/etc/puppetlabs/r10k/r10k.yaml') do
    it { should exist }
  end

  describe 'Dockerfile#running' do
    include_context 'with a docker container'

    describe command('git version') do
      its(:exit_status) { should eq 0 }
    end

    describe command('r10k version') do
      its(:exit_status) { should eq 0 }
    end

    describe command('aws --version') do
      its(:exit_status) { should eq 0 }
    end
  end
end
