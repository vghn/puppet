require 'spec_helper_acceptance'

if hosts.map(&:name).include?('default')
  describe 'Default role' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
        include ::profile::base
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    it_behaves_like 'profile::base'
  end
end
