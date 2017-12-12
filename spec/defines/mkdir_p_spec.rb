require 'spec_helper'

describe 'profile::mkdir_p' do
  context 'should create new directory' do
    let(:title) { '/some/dir/structure' }

    it do
      is_expected.to contain_exec('mkdir_p-/some/dir/structure')
        .with(
          'command' => 'mkdir -p /some/dir/structure',
          'unless'  => 'test -d /some/dir/structure'
        )
    end
  end

  context 'should fail with a path that is not absolute' do
    let(:title) { 'not/a/valid/absolute/path' }

    it do
      expect do
        is_expected.to contain_exec('mkdir_p-not/a/valid/absolute/path')
          .with(
            'command' => 'mkdir -p not/a/valid/absolute/path',
            'unless'  => 'test -d not/a/valid/absolute/path'
          )
      end
        .to raise_error(Puppet::Error)
    end
  end
end
