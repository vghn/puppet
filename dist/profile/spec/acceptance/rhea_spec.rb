require 'spec_helper_acceptance'

describe 'Rhea role', if: hosts.map(&:name).include?('rhea') do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::profile::base
      include ::profile::swap
      include ::profile::log
      include ::profile::git
      include ::profile::jq
      include ::profile::puppet::agent
      include ::profile::puppet::master
      include ::profile::aws::ssm
      include ::profile::docker
    EOS

    # Run it twice and test if idempotent
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it_behaves_like 'profile::base'
  it_behaves_like 'profile::swap'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::jq'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::puppet::master'
  it_behaves_like 'profile::aws::ssm'
  it_behaves_like 'profile::docker'
end
