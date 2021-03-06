require 'spec_helper'

describe 'profile::linuxfw::pre' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::linuxfw::pre') }

        it { is_expected.to contain_firewallchain('INPUT:filter:IPv4') }

        it { is_expected.to contain_firewall('000 accept all icmp') }
        it { is_expected.to contain_firewall('001 accept all to lo interface') }
        it do
          is_expected
            .to contain_firewall(
              '002 reject local traffic not on loopback interface'
            )
        end
        it do
          is_expected
            .to contain_firewall('003 accept related established rules')
        end
        it { is_expected.to contain_firewall('004 accept ssh connections') }

        it { is_expected.to contain_firewall('123 test rule') }
      end
    end
  end
end
