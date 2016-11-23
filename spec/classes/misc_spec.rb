require 'spec_helper'

describe 'profile::misc' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::misc') }

        context 'with ignore_lid_switch' do
          let(:params) { { ignore_lid_switch: true } }
          it do
            is_expected.to contain_ini_setting('Ignore LID close')
              .with(
                ensure: 'present',
                path: '/etc/systemd/logind.conf',
                section: 'Login',
                setting: 'HandleLidSwitch',
                value: 'ignore'
              )
              .that_notifies('Service[systemd-logind]')
          end

          it { is_expected.to contain_service('systemd-logind') }
        end
      end
    end
  end
end
