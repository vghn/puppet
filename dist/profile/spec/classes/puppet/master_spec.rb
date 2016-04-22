require 'spec_helper'

describe 'profile::puppet::master' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            aws_assets_bucket: 'my_bucket'
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::puppet::master') }
        it { is_expected.to contain_class('hiera') }

        it { is_expected.to contain_class('r10k') }
        it do
          is_expected
            .to contain_exec('R10K deploy environment')
            .with_command('/opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile --verbose') # rubocop:disable Metrics/LineLength
        end

        it do
          is_expected
            .to contain_file('R10k Post Run Hook')
            .with_path('/usr/local/bin/r10k-post-run')
            .with_owner('root')
            .with_mode('0555')
        end

        it { is_expected.to contain_file('/etc/puppetlabs/csr') }
        it do
          is_expected
            .to contain_file('CSR Sign')
            .with_path('/etc/puppetlabs/csr/sign')
            .with_owner('root')
            .with_mode('0555')
        end
      end
    end
  end
end
