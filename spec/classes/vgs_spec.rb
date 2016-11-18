require 'spec_helper'

describe 'profile::vgs' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }
        let(:pre_condition) { 'include ::git' }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::vgs') }

        it do
          is_expected.to contain_vcsrepo('VGS Library')
            .with_source('https://github.com/vghn/vgs.git')
            .with_path('/opt/vgs')
        end
      end
    end
  end
end
