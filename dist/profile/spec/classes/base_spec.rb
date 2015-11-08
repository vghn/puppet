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

        if os != 'debian-8-x86_64'
          it do
            should contain_service('puppet')
              .with_ensure('stopped')
              .with_enable('false')
          end
          it do
            should contain_service('mcollective')
              .with_ensure('stopped')
              .with_enable('false')
          end
        end

        it { is_expected.to contain_ssh_authorized_key('testkey') }
      end
    end
  end
end
