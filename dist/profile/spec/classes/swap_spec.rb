require 'spec_helper'

describe 'profile::swap' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }
        let(:params) do
          {
            swapfile: '/var/swap.test.space',
            swapfile_size_mb: 1024
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::swap') }

        it do
          is_expected.to contain_exec('Create swap file')
            .with_command(
              '/bin/dd if=/dev/zero ' \
              'of=/var/swap.test.space bs=1M count=1024'
            )
        end

        it do
          is_expected.to contain_exec('Attach swap file')
            .with_command(
              '/sbin/mkswap /var/swap.test.space && ' \
              '/sbin/swapon /var/swap.test.space'
            )
        end

        it do
          is_expected.to contain_mount('swap')
            .with_fstype('swap')
            .with_device('/var/swap.test.space')
        end
      end
    end
  end
end
