require 'spec_helper_acceptance'

describe 'Zeus role' do
  # Using puppet_apply as a helper
  it 'should work idempotently with no errors' do
    pp = <<-EOS
      # Simulate EC2 instance properties
      $ec2_metadata = {
        placement => {
          availability-zone => 'us-east-1'
        }
      }
      user {'ubuntu':
        ensure     => present,
        managehome => true,
      }
      file {'/home/ubuntu/.ssh':
        ensure  => directory,
        owner   => 'ubuntu',
        group   => 'ubuntu',
        mode    => '0700',
        require => User['ubuntu'],
      }

      include ::profile::base
      include ::profile::ec2
      include ::profile::docker
      include ::profile::puppet::master
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  it_behaves_like 'profile::base'
  it_behaves_like 'profile::ec2'
  it_behaves_like 'profile::docker'
  it_behaves_like 'profile::puppet::master'
end
