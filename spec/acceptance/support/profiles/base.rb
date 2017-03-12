shared_examples 'profile::base' do
  describe 'apt_base_profile', if: fact('osfamily').eql?('Debian') do
    packages = %w(software-properties-common unattended-upgrades)
    packages.each do |pkg|
      describe package(pkg) do
        it { is_expected.to be_installed }
      end
    end

    describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_mode 644 }
    end
  end

  packages = %w(openssh-client openssh-server sudo)
  packages.each do |pkg|
    describe package(pkg) do
      it { is_expected.to be_installed }
    end
  end

  describe user('testuser') do
    it { is_expected.to exist }
    it { is_expected.to have_home_directory '/home/testuser' }
    it { is_expected.to have_login_shell '/bin/bash' }
  end

  describe file('/etc/ssh/sshd_config') do
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_mode 600 }
    its(:content) { is_expected.to match(/PermitRootLogin no/) }
  end

  describe file('/root/.ssh/authorized_keys') do
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_mode 600 }
    its(:content) { is_expected.to match(/ssh-rsa ABCDEF hiera-test-key/) }
  end

  describe cron do
    it { is_expected.to have_entry '2 2 * * * echo "test" 2>&1 | /usr/bin/logger -t CronTest' }
  end

  describe file('/tmp/foo.ini') do
    its(:content) { is_expected.to match(/setting1 = value1/) }
  end

  packages = %w(htop wget ntp)
  packages.each do |pkg|
    describe package(pkg) do
      it { is_expected.to be_installed }
    end
  end

  describe file('/etc/ntp.conf') do
    its(:content) { is_expected.to match(/# ntp\.conf: Managed by puppet/) }
  end

  it_behaves_like 'profile::misc'
  it_behaves_like 'profile::time'
end
