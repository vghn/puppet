require 'spec_helper_acceptance'

describe 'Zeus role', if: hosts.map(&:name).include?('zeus') do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::profile::aws::cloudformation
      include ::profile::aws::ssm
      include ::profile::base
      include ::profile::docker
      include ::profile::git
      include ::profile::jq
      include ::profile::puppet::agent
      include ::profile::puppet::master
      include ::profile::rvm
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it_behaves_like 'profile::aws::cloudformation'
  it_behaves_like 'profile::aws::ssm'
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::docker'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::jq'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::puppet::master'
  it_behaves_like 'profile::rvm'
end
