require 'spec_helper'

describe 'profile::puppet::master' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::puppet::master') }

        it { is_expected.to contain_file('/etc/init/rhea.conf') }

        it do
          is_expected.to contain_cron('Backup')
            .with_command("bash -c 'docker run --rm --name backup --hostname " \
            'backup -v /opt/vpm/puppet:/vpm --volumes-from puppet_data_1 ' \
            "vladgh/awscli:latest /vpm/bin/backup'")
        end
      end
    end
  end
end
