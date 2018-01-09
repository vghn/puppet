require 'spec_helper'

describe 'profile::dotfiles' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }
        let(:pre_condition) {[
          'include ::git',
          'include ::profile::vgs'
        ]}

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('profile::dotfiles') }
        it { is_expected.to contain_class('profile::vgs') }

        context 'with default parameters' do
          it do
            is_expected.to contain_vcsrepo('DotFiles Vlad')
              .with_source('https://github.com/vladgh/dotfiles')
              .with_path('/opt/dotfiles')
          end
        end

        context 'with repo => example.com' do
          let(:params) {{ 'repo' => 'example.com' }}

          it do
            is_expected.to contain_vcsrepo('DotFiles Vlad')
              .with_source('example.com')
          end
        end

        context 'with path => /tmp/dotfiles' do
          let(:params) {{ 'path' => '/tmp/dotfiles' }}

          it do
            is_expected.to contain_vcsrepo('DotFiles Vlad')
              .with_path('/tmp/dotfiles')
          end
        end
      end
    end
  end
end
