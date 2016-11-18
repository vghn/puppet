require 'spec_helper'

describe 'profile::aws::cloudwatch' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::aws::cloudwatch') }

        it { is_expected.to contain_class('cloudwatchlogs') }
        it do
          is_expected.to contain_cloudwatchlogs__log('TEST/System/SysLog')
        end
      end
    end
  end
end
