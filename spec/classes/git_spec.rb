require 'spec_helper'

describe 'profile::git' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::git') }

        let(:pre_condition) { 'include ::apt' }
        it { is_expected.to contain_class('apt') }
        it { is_expected.to contain_apt__ppa('ppa:git-core/ppa') }
        it do
          is_expected.to contain_class('git')
            .with_package_ensure('latest')
        end
      end
    end
  end
end
