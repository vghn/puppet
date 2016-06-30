require 'spec_helper'

describe 'profile::aws::cloudformation' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::aws::cloudformation') }

        it do
          is_expected.to contain_package('AWS CloudFormation')
            .with_name('aws-cfn-bootstrap')
            .with_provider('pip')
        end

        it do
          is_expected.to contain_file('/etc/init.d/cfn-hup')
            .with_target('/usr/local/init/ubuntu/cfn-hup')
        end

        it { is_expected.to contain_service('cfn-hup') }
      end
    end
  end
end
