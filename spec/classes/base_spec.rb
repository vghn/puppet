require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            os: {
              family: 'Debian',
              name: 'Ubuntu',
              distro: { codename: 'trusty' },
              release: { full: '16.04', major: '16.04' }
            }
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('stdlib') }
        if facts[:os]['family'] == 'Debian'
          it { is_expected.to contain_class('apt') }
          it { is_expected.to contain_class('unattended_upgrades') }
          it { is_expected.to contain_package('software-properties-common') }
        end

        it { is_expected.to contain_user('testuser').with_managehome('true') }
        it { is_expected.to contain_ssh_authorized_key('hiera-test-key') }
        it { is_expected.to contain_cron('test').with_command('true') }
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
