require 'spec_helper'

describe 'profile::jq' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::jq') }

        it { is_expected.to contain_wget__fetch('JQ JSON Processor') }
        it do
          is_expected.to contain_file('/usr/local/bin/jq')
            .with_mode('0755')
        end
      end
    end
  end
end
