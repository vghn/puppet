require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('stdlib') }
        it { is_expected.to contain_class('apt') }
        it { is_expected.to contain_class('unattended_upgrades') }
        it { is_expected.to contain_package('software-properties-common') }

        case facts[:os]['name']
        when 'Ubuntu'
          it do
            is_expected.to contain_apt__source("archive.ubuntu.com-#{facts[:os]['lsb']['distcodename']}")
              .with_location('http://archive.ubuntu.com/ubuntu')
              .with_repos('main universe multiverse restricted')
          end

          it do
            is_expected.to contain_apt__source("archive.ubuntu.com-#{facts[:os]['lsb']['distcodename']}-updates")
              .with_location('http://archive.ubuntu.com/ubuntu')
              .with_repos('main universe multiverse restricted')
          end

          it do
            is_expected.to contain_apt__source("archive.ubuntu.com-#{facts[:os]['lsb']['distcodename']}-security")
              .with_location('http://archive.ubuntu.com/ubuntu')
              .with_repos('main universe multiverse restricted')
          end

          it do
            is_expected.to contain_apt__source("archive.ubuntu.com-#{facts[:os]['lsb']['distcodename']}-backports")
              .with_location('http://archive.ubuntu.com/ubuntu')
              .with_repos('main universe multiverse restricted')
          end
        end

        it do
          is_expected.to contain_accounts__user('testaccount')
            .with_managehome('true')
            .with_shell('/bin/bash')
            .with_uid('11111')
            .with_gid('11111')
            .with_sshkeys(['ssh-rsa ABCDAAAAB3NzaC1yc2EAAAADAQABAAAAgQDeNjkYh/B0IGF8MmOUM0auLSleS+v7sQx4JAmmfYiBih31aLdF1GRH+1KlLcldWuPSjyGtVWUjm4ytA5zUfPUp6DyHAYzYIdz1zDIbL+DiOsmJBwD/PyQsA3gOQWcbgfk9RxqFm6fbmL0MhE/WwaAIveneawCKdUYoLL/4gkOVWw==EF demokey'])
        end

        it do
          is_expected.to contain_user('testuser')
            .with_managehome('true')
            .with_shell('/bin/bash')
        end

        it do
          is_expected.to contain_ssh_authorized_key('hiera-ssh-testuser-key')
            .with_user('testuser')
            .with_type('ssh-rsa')
        end

        it do
          is_expected.to contain_gnupg_key('hiera-gpg-test-key')
            .with_user('testuser')
            .with_key_id('B3E9A9F3')
        end

        it do
          is_expected.to contain_cron('test')
            .with_command('echo "test" 2>&1 | /usr/bin/logger -t CronTest')
        end
        it { is_expected.to contain_ini_setting('test setting') }
        it { is_expected.to contain_package('htop') }

        it { is_expected.to contain_class('profile::git') }
        it do
          is_expected.to contain_vcsrepo('Test Repo')
            .with_source('https://github.com/vladgh/test')
            .with_path('/home/testuser/test')
        end

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
