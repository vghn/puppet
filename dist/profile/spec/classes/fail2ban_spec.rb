require 'spec_helper'

describe 'profile::fail2ban' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::fail2ban') }
        it { is_expected.to contain_class('fail2ban') }
      end
    end
  end
end
