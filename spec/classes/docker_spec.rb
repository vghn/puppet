require 'spec_helper'

describe 'profile::docker' do
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
        it { is_expected.to contain_class('profile::docker') }

        # Fix until the docker module supports the latest repository and package
        it { is_expected.to contain_class('apt') }
        it { is_expected.to contain_apt__key('docker') }
        it { is_expected.to contain_apt__source('docker') }
        it { is_expected.to contain_package('docker-ce') }
        it do
          is_expected.to contain_package('docker-engine').with({
            'ensure' => 'absent'
          })
        end
        it do
          is_expected.to contain_package('docker.io').with({
            'ensure' => 'absent'
          })
        end

        # it { is_expected.to contain_class('docker') }
        # it { is_expected.to contain_class('docker::compose') }

        # it { is_expected.to contain_docker__image('busybox') }
        # it { is_expected.to contain_docker__run('test') }
        # it do
          # is_expected.to contain_file('/usr/local/bin/update_docker_image.sh')
        # end

        # it { is_expected.to contain_package('docker') }
        # it { is_expected.to contain_package('apparmor') }
        # it { is_expected.to contain_package('cgroup-lite') }
        # it { is_expected.to contain_apt__pin('docker') }
        # it { is_expected.to contain_user('vagrant') }
      end
    end
  end
end
