require 'spec_helper_acceptance'

describe 'profile::base' do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
    class { 'profile::base': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes  => true)
  end
end
