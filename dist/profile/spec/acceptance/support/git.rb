shared_examples 'profile::git' do
  release = command('/usr/bin/lsb_release -cs').stdout.chomp

  describe file("/etc/apt/sources.list.d/git-core-ppa-#{release}.list") do
    it { is_expected.to contain 'http://ppa.launchpad.net/git-core/ppa/ubuntu' }
  end

  describe package('git') do
    it { is_expected.to be_installed }
  end
end
