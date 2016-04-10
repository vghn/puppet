require 'spec_helper'

describe 'profile::docker' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::docker') }

        it { is_expected.to contain_class('docker') }
        it { is_expected.to contain_class('docker::compose') }

        it { is_expected.to contain_package('docker') }
        it { is_expected.to contain_package('apparmor') }
        it { is_expected.to contain_package('cgroup-lite') }
        it { is_expected.to contain_apt__pin('docker') }
        it { is_expected.to contain_user('ubuntu') }

        it { is_expected.to contain_wget__fetch('Docker-Machine Binary') }
        it do
          is_expected.to contain_file('/usr/local/bin/docker-machine')
            .that_requires('Wget::Fetch[Docker-Machine Binary]')
        end

        context 'on EC2 w/ cluster' do
          let(:facts) do
            facts.merge(
              ec2_metadata: {
                placement: { :'availability-zone' => 'us-east-1' }
              },
              aws_ecs_cluster: 'default'
            )
          end
          it { is_expected.to contain_file('/var/log/ecs') }
          it { is_expected.to contain_file('/var/lib/ecs') }
          it { is_expected.to contain_file('/var/lib/ecs/data') }
          it { is_expected.to contain_docker__run('ecs-agent') }
        end

        context 'on EC2 w/o cluster' do
          let(:facts) do
            facts.merge(
              ec2_metadata: {
                placement: { :'availability-zone' => 'us-east-1' }
              }
            )
          end

          it { is_expected.to contain_docker__image('amazon/amazon-ecs-agent') }
          it do
            is_expected.to contain_file('/usr/local/bin/update_docker_image.sh')
          end
        end
      end
    end
  end
end
