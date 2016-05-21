require 'spec_helper'

describe 'profile::aws::s3fs' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::aws::s3fs') }

        it { is_expected.to contain_package('libcurl4-gnutls-dev') }
        it { is_expected.to contain_package('libfuse-dev') }
        it { is_expected.to contain_package('libssl-dev') }
        it { is_expected.to contain_package('libxml2-dev') }
        it { is_expected.to contain_wget__fetch('S3FS-Fuse Deb') }
        it do
          is_expected.to contain_package('S3FS-Fuse')
            .with_name('s3fs-fuse')
            .with_provider('dpkg')
        end
      end
    end
  end
end
