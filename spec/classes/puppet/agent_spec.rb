require 'spec_helper'

describe 'profile::puppet::agent' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::puppet::agent') }

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
        it do
          is_expected.to contain_service('pxp-agent')
            .with_ensure('stopped')
            .with_enable('false')
        end

        it do
          is_expected.to contain_cron('Puppet Run')
            .with_command('puppet agent --onetime ' \
            '--no-daemonize --verbose --logdest syslog > /dev/null 2>&1')
        end
      end
    end
  end
end
