require 'spec_helper'

describe 'profile::docker' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::docker') }

        case facts[:lsbdistid]
        when 'Ubuntu'
          it { is_expected.to contain_class('apt') }

          it { is_expected.to contain_class('docker') }
          it { is_expected.to contain_class('docker::compose') }

          it { is_expected.to contain_docker__image('busybox') }
          it { is_expected.to contain_docker__run('test') }
          it do
            is_expected.to contain_file('/usr/local/bin/update_docker_image.sh')
          end

          it { is_expected.to contain_package('docker') }
          it { is_expected.to contain_package('apparmor') }
          it { is_expected.to contain_package('cgroup-lite') }
          it { is_expected.to contain_apt__pin('docker') }
          it { is_expected.to contain_user('vagrant') }
        end
      end
    end
  end
end
