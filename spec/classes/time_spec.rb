require 'spec_helper'

describe 'profile::time' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        context 'w/o parameters' do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile::time') }
        end

        context 'w/ zone parameter' do
          let(:params) { { zone: 'US/Central' } }

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('tzdata') }

          it do
            is_expected.to contain_file('/etc/localtime')
              .with_source('file:///usr/share/zoneinfo/US/Central')
          end
          it do
            is_expected.to contain_file('/etc/timezone')
              .with_content("US/Central\n")
          end
        end
      end
    end
  end
end
