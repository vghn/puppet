require 'spec_helper_acceptance'

describe 'Hera role', if: hosts.map(&:name).include?('hera') do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::profile::base
      include ::profile::ec2
      include ::profile::docker
      include ::profile::puppet::master
    EOS

    # Run it twice and test for idempotency
    apply_manifest_on(:hera, pp, catch_failures: true)
    apply_manifest_on(:hera, pp, catch_changes: true)
  end

  it_behaves_like 'profile::base'
  it_behaves_like 'profile::ec2'
  it_behaves_like 'profile::docker'
  it_behaves_like 'profile::puppet::master'
end

