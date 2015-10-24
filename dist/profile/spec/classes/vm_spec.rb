require 'spec_helper'

describe 'profile::vm' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { should compile.with_all_deps }
        it { should contain_class('profile::vm') }
        it { should contain_class('profile::base') }

        it { should contain_package('vim') }
      end
    end
  end
end
