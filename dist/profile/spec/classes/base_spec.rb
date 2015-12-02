require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('stdlib') }
        it { is_expected.to contain_class('apt') }
        it { is_expected.to contain_class('ntp') }

        it do
          is_expected.to contain_service('puppet')
            .with_ensure('stopped')
            .with_enable('false')
        end
        it do
          is_expected.to contain_service('mcollective')
            .with_ensure('stopped')
            .with_enable('false')
        end

        it { is_expected.to contain_ssh_authorized_key('test-key') }
      end
    end
  end
end
