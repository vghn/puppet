require 'spec_helper'

describe 'profile::ec2' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            ec2_metadata: { placement: { :'availability-zone' => 'us-east-1' } }
          )
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::ec2') }

        it { is_expected.to contain_class('apt') }
        it { is_expected.to contain_package('software-properties-common') }
        it { is_expected.to contain_apt__ppa('ppa:git-core/ppa') }
        it { is_expected.to contain_class('git') }

        it do
          is_expected.to contain_rsyslog__imfile('Testing')
            .with_file_name('/var/log/test.log')
        end

        it { is_expected.to contain_class('cloudwatchlogs') }
        it do
          is_expected.to contain_cloudwatchlogs__log('TEST/System/SysLog')
        end

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

        it { is_expected.to contain_class('rvm') }
        it { is_expected.to contain_group('rvm') }
        it { is_expected.to contain_rvm_system_ruby('ruby-2.2.1') }

        it { is_expected.to contain_wget__fetch('JQ JSON Processor') }
        it do
          is_expected.to contain_file('/usr/local/bin/jq')
            .with_mode('0755')
        end
      end
    end
  end
end
