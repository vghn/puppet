require 'spec_helper'

describe 'profile::aws::codedeploy' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::aws::codedeploy') }

        it { is_expected.to contain_package('ruby2.0') }
        it { is_expected.to contain_package('gdebi-core') }
        it { is_expected.to contain_wget__fetch('CodeDeploy Deb') }
        it do
          is_expected.to contain_package('CodeDeploy Agent')
            .with_name('codedeploy-agent')
            .with_provider('dpkg')
        end
        it do
          is_expected.to contain_service('CodeDeploy Service')
            .with_name('codedeploy-agent')
        end
      end
    end
  end
end
