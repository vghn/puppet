shared_examples 'profile::git' do
  if release == 'trusty'
    repo_file = "/etc/apt/sources.list.d/git-core-ppa-#{fact('os')['distro']['codename']}.list"
  else
    repo_file = "/etc/apt/sources.list.d/git-core-ubuntu-ppa-#{fact('os')['distro']['codename']}.list"
  end

  describe file(repo_file) do
    its(:content) { is_expected.to match %r{deb http://ppa.launchpad.net/git-core/ppa/ubuntu #{fact('os')['distro']['codename']} main} }
  end

  describe package('git') do
    it { is_expected.to be_installed }
  end
end
