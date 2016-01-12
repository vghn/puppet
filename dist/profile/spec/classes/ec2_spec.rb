require 'spec_helper'

describe 'profile::ec2' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::ec2') }
        it { is_expected.to contain_class('profile::base') }

        it { is_expected.to contain_package('curl') }
        it { is_expected.to contain_package('nfs-common') }
        it { is_expected.to contain_package('mysql-client') }
        it { is_expected.to contain_package('python-pip') }
        it { is_expected.to contain_package('wget') }

        it { is_expected.to contain_apt__ppa('ppa:git-core/ppa') }
        it { is_expected.to contain_class('git') }

        it { is_expected.to contain_package('awscli').with_provider('pip') }

        it do
          is_expected.to contain_package('AWS CloudFormation')
            .with_name('aws-cfn-bootstrap')
            .with_provider('pip')
        end

        it { is_expected.to contain_package('ruby2.0') }
        it { is_expected.to contain_package('gdebi-core') }
        it { is_expected.to contain_wget__fetch('CodeDeploy Deb') }
        it do
          is_expected.to contain_package('CodeDeploy Agent')
            .with_name('codedeploy-agent')
            .with_provider('dpkg')
        end
        it do
          is_expected.to contain_service('CodeDeploy Service')
            .with_name('codedeploy-agent')
        end

        it { is_expected.to contain_wget__fetch('AWS SSM Agent Deb') }
        it do
          is_expected.to contain_package('AWS SSM Agent')
            .with_name('amazon-ssm-agent')
            .with_provider('dpkg')
        end
        it do
          is_expected.to contain_service('AWS SSM Agent')
            .with_name('amazon-ssm-agent')
        end
      end
    end
  end
end
