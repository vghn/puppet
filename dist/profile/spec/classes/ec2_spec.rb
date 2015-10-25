require 'spec_helper'

describe 'profile::ec2' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { should compile.with_all_deps }
        it { should contain_class('profile::ec2') }
        it { should contain_class('profile::base') }

        it { should contain_package('nfs-common') }
        it { should contain_package('mysql-client') }
        it { should contain_package('ruby2.0') }
        it { should contain_package('gdebi-core') }

        it { should contain_package('AWS SDK CLI').with_name('aws-sdk').with_provider('puppet_gem') }

        it { should contain_package('AWS CloudFormation').with_name('aws-cfn-bootstrap').with_provider('pip') }

        it { should contain_package('wget') }
        it { should contain_wget__fetch('CodeDeploy Deb') }
        it { should contain_package('CodeDeploy Agent').with_name('codedeploy-agent').with_provider('dpkg') }
        it { should contain_service('CodeDeploy Service').with_name('codedeploy-agent') }
      end
    end
  end
end
