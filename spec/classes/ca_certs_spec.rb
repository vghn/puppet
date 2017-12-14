require 'spec_helper'

describe 'profile::ca_certs' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::ca_certs') }

        it do
          is_expected.to contain_file('CA Certificates')
            .with_path('/usr/local/share/ca-certificates')
        end

        it do
          is_expected.to contain_exec('update-ca-certificates')
            .with(
              'command'     => '/usr/sbin/update-ca-certificates --fresh',
              'refreshonly' => true,
            )
        end
      end
    end
  end
end
