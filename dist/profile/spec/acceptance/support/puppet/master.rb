shared_examples 'profile::puppet::master' do
  describe file('/opt/myproject/scripts/start-logging-container') do
    it { is_expected.to exist }
    it { should be_owned_by 'root' }
    it { should be_executable.by_user('root') }
    its(:content) { should match %r{#!/usr/bin/env bash} }
  end

  describe file('/opt/myproject/scripts/r10k-deploy') do
    it { is_expected.to exist }
    it { should be_owned_by 'root' }
    it { should be_executable.by_user('root') }
    its(:content) { should match %r{#!/usr/bin/env bash} }
  end

  describe file('/opt/myproject/scripts/r10k-post-run') do
    it { is_expected.to exist }
    it { should be_owned_by 'root' }
    it { should be_executable.by_user('root') }
    its(:content) { should match %r{#!/usr/bin/env bash} }
  end

  describe file('/opt/myproject/scripts/csr-sign') do
    it { is_expected.to exist }
    it { should be_owned_by 'root' }
    it { should be_executable.by_user('root') }
    its(:content) { should match %r{#!/opt/puppetlabs/puppet/bin/ruby} }
  end
end
