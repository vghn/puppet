shared_examples 'profile::base' do
  describe package('curl') do
    it { is_expected.to be_installed }
  end
  describe package('nfs-common') do
    it { is_expected.to be_installed }
  end
  describe package('mysql-client') do
    it { is_expected.to be_installed }
  end
  describe package('wget') do
    it { is_expected.to be_installed }
  end
  describe package('tmux') do
    it { is_expected.to be_installed }
  end
  describe package('vim') do
    it { is_expected.to be_installed }
  end
  describe package('unzip') do
    it { is_expected.to be_installed }
  end

  if fact('virtual').eql?('virtualbox')
    context 'vagrant tests' do
      describe user('vagrant') do
        it { is_expected.to have_authorized_key 'ssh-rsa' }
      end
    end
  else
    context 'ec2 tests' do
      describe user('ubuntu') do
        it { is_expected.to have_authorized_key 'ssh-rsa' }
      end
    end
  end
end
