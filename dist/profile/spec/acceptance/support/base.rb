shared_examples 'profile::base' do
  describe package('python') do
    it { is_expected.to be_installed }
  end

  describe package('curl') do
    it { is_expected.to be_installed }
  end
  describe package('htop') do
    it { is_expected.to be_installed }
  end
  describe package('mysql-client') do
    it { is_expected.to be_installed }
  end
  describe package('nfs-common') do
    it { is_expected.to be_installed }
  end
  describe package('tmux') do
    it { is_expected.to be_installed }
  end
  describe package('unzip') do
    it { is_expected.to be_installed }
  end
  describe package('vim') do
    it { is_expected.to be_installed }
  end
  describe package('wget') do
    it { is_expected.to be_installed }
  end
end
