require 'spec_helper'

describe 'profile::monitor' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::monitor') }
        it { is_expected.to contain_class('prometheus::node_exporter') }

        it { is_expected.to contain_profile__mkdir_p('/var/lib/node_exporter/textfile_collector') }
        it { is_expected.to contain_exec('mkdir_p-/var/lib/node_exporter/textfile_collector') }
      end
    end
  end
end
