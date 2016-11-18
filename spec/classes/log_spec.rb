require 'spec_helper'

describe 'profile::log' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::log') }

        it { is_expected.to contain_class('rsyslog::client') }
        it do
          is_expected.to contain_rsyslog__imfile('testing')
            .with_file_name('/var/log/test.log')
        end
      end
    end
  end
end
