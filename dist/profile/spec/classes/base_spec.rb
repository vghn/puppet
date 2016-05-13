require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('stdlib') }
        it { is_expected.to contain_class('apt') }
        it { is_expected.to contain_class('ntp') }

        it { is_expected.to contain_package('curl') }
        it { is_expected.to contain_package('nfs-common') }
        it { is_expected.to contain_package('mysql-client') }
        it { is_expected.to contain_package('wget') }
        it { is_expected.to contain_package('tmux') }
        it { is_expected.to contain_package('vim') }
        it { is_expected.to contain_package('unzip') }

        it { is_expected.to contain_ssh_authorized_key('test-key') }

        it { is_expected.to contain_class('rsyslog::client') }
        it do
          is_expected.to contain_rsyslog__imfile('Testing')
            .with_file_name('/var/log/test.log')
        end
      end
    end
  end
end
