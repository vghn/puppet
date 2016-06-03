require 'spec_helper'

describe 'profile::puppet::master' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::puppet::master') }

        it { is_expected.to contain_common__mkdir_p('/opt/myproject/scripts') }

        it do
          is_expected.to contain_file('Start Logging Container')
            .with_path('/opt/myproject/scripts/start-logging-container')
            .with_content(%r{#!/usr/bin/env bash})
            .with_owner('root')
            .with_mode('0755')
        end

        it do
          is_expected.to contain_file('R10k Deploy')
            .with_path('/opt/myproject/scripts/r10k-deploy')
            .with_owner('root')
            .with_mode('0755')
        end

        it do
          is_expected.to contain_file('R10k Post Run Hook')
            .with_path('/opt/myproject/scripts/r10k-post-run')
            .with_owner('root')
            .with_mode('0755')
        end
        it do
          is_expected.to contain_file('CSR Auto Sign')
            .with_path('/opt/myproject/scripts/csr-sign')
            .with_owner('root')
            .with_mode('0555')
        end
      end
    end
  end
end
