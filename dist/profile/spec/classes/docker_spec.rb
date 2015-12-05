require 'spec_helper'

describe 'profile::docker' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::docker') }
        it { is_expected.to contain_class('profile::base') }
        it { is_expected.to contain_class('docker') }

        it { is_expected.to contain_package('apparmor') }
        it { is_expected.to contain_package('apt-transport-https') }
        it { is_expected.to contain_package('cgroup-lite') }

        it { is_expected.to contain_apt__pin('docker') }
      end
    end
  end
end
