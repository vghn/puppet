require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('stdlib') }
        if facts[:osfamily] == 'Debian'
          it { is_expected.to contain_class('apt') }
        end

        it { is_expected.to contain_cron('test').with_command('true') }
        it { is_expected.to contain_ssh_authorized_key('hiera-test-key') }
        it { is_expected.to contain_ini_setting('test setting') }
        it { is_expected.to contain_package('htop') }

        it { is_expected.to contain_class('sudo') }
        it { is_expected.to contain_class('sudo::configs') }
        it { is_expected.to contain_class('ssh') }
        it { is_expected.to contain_class('wget') }
        it { is_expected.to contain_class('ntp') }

        it { is_expected.to contain_class('profile::time') }
        it { is_expected.to contain_class('profile::misc') }
      end
    end
  end
end
