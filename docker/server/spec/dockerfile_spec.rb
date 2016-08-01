require 'spec_helper'

CURRENT_DIRECTORY = File.dirname(File.dirname(__FILE__))

describe 'Dockerfile' do
  include_context 'with a docker image'

  it 'uses the correct version of Ubuntu' do
    os_version = command('cat /etc/lsb-release').stdout
    expect(os_version).to include('16.04')
    expect(os_version).to include('Ubuntu')
  end

  describe package('puppetserver') do
    it { is_expected.to be_installed }
  end

  describe package('aws-sdk') do
    it { is_expected.to be_installed.by('gem') }
  end

  describe user('puppet') do
    it { should exist }
  end

  describe file('/opt/puppetlabs/bin/puppetserver') do
    it { should exist }
    it { should be_executable }
  end

  describe 'Dockerfile#config' do
    it 'should expose the puppetserver port' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to include('8140/tcp')
    end
  end

  describe 'Dockerfile#running' do
    include_context 'with a docker container'

    describe command('puppetserver --version') do
      its(:exit_status) { should eq 0 }
    end
  end
end
