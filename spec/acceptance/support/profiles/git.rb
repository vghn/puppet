shared_examples 'profile::git' do
  release = command('/usr/bin/lsb_release -cs').stdout.chomp

  case release
  when 'trusty'
    repo_file = "/etc/apt/sources.list.d/git-core-ppa-#{release}.list"
  when 'xenial'
    repo_file = "/etc/apt/sources.list.d/git-core-ubuntu-ppa-#{release}.list"
  end

  describe file(repo_file) do
    its(:content) { is_expected.to match %r{http://ppa.launchpad.net/git-core/ppa/ubuntu} }
  end

  describe package('git') do
    it { is_expected.to be_installed }
  end
end
