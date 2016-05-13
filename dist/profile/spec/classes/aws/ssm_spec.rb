require 'spec_helper'

describe 'profile::aws::ssm' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::aws::ssm') }

        it { is_expected.to contain_wget__fetch('AWS SSM Agent Deb') }
        it do
          is_expected.to contain_package('AWS SSM Agent')
            .with_name('amazon-ssm-agent')
            .with_provider('dpkg')
        end
        it do
          is_expected.to contain_service('AWS SSM Agent')
            .with_name('amazon-ssm-agent')
        end
      end
    end
  end
end
