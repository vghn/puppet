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

        context 'inside CloudFormation user data' do
          let(:facts) do
            facts.merge(
              ca_s3_path:   's3://bucket/ca',
              aws_cfn_name: 'mystack'
            )
          end
          it do
            is_expected.to contain_exec('ca_vpm_dir')
              .that_comes_before('Docker::Run[ca-s3-sync]')
          end
          it { is_expected.to contain_docker__run('ca-s3-sync') }
        end

        it { is_expected.to contain_docker__image('vladgh/s3sync:latest') }
      end
    end
  end
end
