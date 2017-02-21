require 'spec_helper_acceptance'

describe "#{ROLE} role" do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      include ::role::#{ROLE}
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it_behaves_like "role::#{ROLE}"
end
