require 'spec_helper'

describe 'profile::vm' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::vm') }
        it { is_expected.to contain_class('profile::base') }

        it { is_expected.to contain_package('vim') }
      end
    end
  end
end
