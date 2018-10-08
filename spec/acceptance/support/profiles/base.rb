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

  describe group('testaccount') do
    it { is_expected.to exist }
    it { is_expected.to have_gid '11111' }
  end

  describe user('testaccount') do
    it { is_expected.to exist }
    it { is_expected.to have_home_directory '/home/testaccount' }
    it { is_expected.to have_login_shell '/bin/bash' }
    it { is_expected.to belong_to_primary_group 'testaccount' }
    it { is_expected.to have_uid '11111' }
    it { is_expected.to have_authorized_key 'ABCDAAAAB3NzaC1yc2EAAAADAQABAAAAgQDeNjkYh/B0IGF8MmOUM0auLSleS+v7sQx4JAmmfYiBih31aLdF1GRH+1KlLcldWuPSjyGtVWUjm4ytA5zUfPUp6DyHAYzYIdz1zDIbL+DiOsmJBwD/PyQsA3gOQWcbgfk9RxqFm6fbmL0MhE/WwaAIveneawCKdUYoLL/4gkOVWw==EF' }
  end

  describe user('testuser') do
    it { is_expected.to exist }
    it { is_expected.to have_home_directory '/home/testuser' }
    it { is_expected.to have_login_shell '/bin/bash' }
    it { is_expected.to have_authorized_key 'ABCDAAAAB3NzaC1yc2EAAAADAQABAAAAgQDeNjkYh/B0IGF8MmOUM0auLSleS+v7sQx4JAmmfYiBih31aLdF1GRH+1KlLcldWuPSjyGtVWUjm4ytA5zUfPUp6DyHAYzYIdz1zDIbL+DiOsmJBwD/PyQsA3gOQWcbgfk9RxqFm6fbmL0MhE/WwaAIveneawCKdUYoLL/4gkOVWw==EF' }
  end

  describe file('/etc/ssh/sshd_config') do
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_mode 600 }
    its(:content) { is_expected.to match(/PermitRootLogin no/) }
  end

  describe command('sudo gpg --homedir /home/testuser/.gnupg --list-keys B3E9A9F3') do
    its(:stdout) { is_expected.to match /B3E9A9F3/ }
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe cron do
    it { is_expected.to have_entry '2 2 * * * echo "test" 2>&1 | /usr/bin/logger -t CronTest' }
  end

  describe file('/tmp/foo.ini') do
    its(:content) { is_expected.to match(/setting1 = value1/) }
  end

  describe file('/home/testuser/test/README.md') do
    it { is_expected.to exist }
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
