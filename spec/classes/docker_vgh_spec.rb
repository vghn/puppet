require 'spec_helper'

describe 'profile::docker_vgh' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::docker_vgh') }

        case facts[:osfamily]
        when 'Debian'
          it { is_expected.to contain_class('apt') }
          it { is_expected.to contain_apt__source('docker') }
          it { is_expected.to contain_package('docker-ce') }
          it do
            is_expected.to contain_package('docker-engine').with(
              'ensure' => 'absent'
            )
          end
          it do
            is_expected.to contain_package('docker.io').with(
              'ensure' => 'absent'
            )
          end
          it do
            is_expected.to contain_service('docker').with(
              'ensure' => 'running',
              'enable' => true
            )
          end
        end
      end
    end
  end
end
