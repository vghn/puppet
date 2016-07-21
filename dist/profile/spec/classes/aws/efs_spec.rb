require 'spec_helper'

describe 'profile::aws::efs' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::aws::efs') }

        it { is_expected.to contain_package('nfs-common') }
        it { is_expected.to contain_vg__mkdir_p('/efs') }

        it do
          is_expected.to contain_mount('/efs')
            .with_device('us-east-1a.fs-1234.efs.us-east-1.amazonaws.com:/')
            .with_fstype('nfs4')
        end
      end
    end
  end
end
