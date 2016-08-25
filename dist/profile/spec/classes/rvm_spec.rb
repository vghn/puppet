require 'spec_helper'

describe 'profile::rvm' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            root_home: '/root'
          )
        end
        let(:pre_condition) { 'include ::gnupg' }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::rvm') }
        it { is_expected.to contain_class('rvm') }
        it { is_expected.to contain_group('rvm') }
        it { is_expected.to contain_rvm_system_ruby('ruby-2.3') }
      end
    end
  end
end
