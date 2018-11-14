require 'spec_helper'

describe 'profile::puppet::agent' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::puppet::agent') }

        case facts[:os]['name']
        when 'Ubuntu'
          it do
            is_expected.to contain_apt__source("apt.puppetlabs.com-#{facts[:os]['lsb']['distcodename']}")
              .with_location('http://apt.puppetlabs.com')
              .with_repos('main')
              .with_key('6F6B15509CF8E59E6E469F327F438280EF8D349F')
          end
        end

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
