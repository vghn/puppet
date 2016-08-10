require 'spec_helper'

describe 'profile::linuxfw::post' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::linuxfw::post') }

        it { is_expected.to contain_firewall('998 input reject') }
        it { is_expected.to contain_firewall('999 forward reject') }
      end
    end
  end
end
