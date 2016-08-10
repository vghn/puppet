require 'spec_helper'

describe 'profile::linuxfw' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('firewall') }
        it { is_expected.to contain_resources('firewall') }

        it { is_expected.to contain_class('profile::linuxfw') }
        it { is_expected.to contain_class('profile::linuxfw::pre') }
        it { is_expected.to contain_class('profile::linuxfw::post') }
      end
    end
  end
end
