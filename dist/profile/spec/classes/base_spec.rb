require 'spec_helper'

describe 'profile::base' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('stdlib') }
        if facts[:osfamily] == 'Debian'
          it { is_expected.to contain_class('apt') }
        end
        it { is_expected.to contain_class('ntp') }
        it { is_expected.to contain_class('vg') }
        it { is_expected.to contain_class('vg::time') }
      end
    end
  end
end
