require 'spec_helper'

describe 'profile::puppet::master' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::puppet::master') }
        it { is_expected.to contain_class('hiera') }
        it { is_expected.to contain_class('r10k') }
        it do
          is_expected
            .to contain_file('/usr/local/bin/puppet_vgh_master_update')
            .with_owner('root')
            .with_mode('0555')
        end
      end
    end
  end
end
