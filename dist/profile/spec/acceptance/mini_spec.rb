require 'spec_helper_acceptance'

describe 'Mini role', if: hosts.map(&:name).include?('mini') do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::profile::base
      include ::profile::log
      include ::profile::git
      include ::profile::samba
      include ::profile::puppet::agent
      include ::profile::docker
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it_behaves_like 'profile::base'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::samba'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::docker'
end
