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

        it { should contain_package('aws-sdk').with_provider('puppet_gem') }
        it { should contain_package('AWS CloudFormation').with_name('aws-cfn-bootstrap').with_provider('pip') }
      end
    end
  end
end
