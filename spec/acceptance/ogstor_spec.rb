require 'spec_helper_acceptance'

describe 'OGStor role', if: hosts.map(&:name).include?('ogstor') do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::role::ogstor
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it_behaves_like 'role::ogstor'
end
