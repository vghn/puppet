require 'spec_helper'

describe 'profile::samba' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::samba') }
        it { is_expected.to contain_class('samba::server') }
      end
    end
  end
end
