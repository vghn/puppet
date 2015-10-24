require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { should contain_class('profile::base') }
        it { should compile.with_all_deps }

        it { should contain_service('puppet').with_ensure('stopped').with_enable('false') }
        it { should contain_service('mcollective').with_ensure('stopped').with_enable('false') }
      end
    end
  end
end
