require 'spec_helper'

describe 'profile::log' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }
        let(:params) do
          {
            'server_address' => 'my.logserver.com',
            'server_port'    => 514,
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::log') }

        it { is_expected.to contain_class('rsyslog::client') }
        it do
          is_expected.to contain_rsyslog__imfile('testing')
            .with_file_name('/var/log/test.log')
        end

        context 'with ssl => true' do
          let(:params) do
            super().merge({
              'ssl'           => true,
              'ssl_ca'        => 'sample_certificate',
            })
          end

          it do
            is_expected.to contain_file('Log Certificates')
              .with_path('/etc/ssl/log_certs')
          end
        end
      end
    end
  end
end
