require 'spec_helper'

describe 'profile::samba' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::samba') }
        it { is_expected.to contain_class('samba::server') }

        it { is_expected.to contain_group('sambashare') }
        it { is_expected.to contain_file('/data/test_share') }
        it { is_expected.to contain_exec('mkdir_p-/data/test_share') }
        it { is_expected.to contain_profile__mkdir_p('/data/test_share') }
      end
    end
  end
end
