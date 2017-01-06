shared_examples 'profile::base' do
  describe 'apt_base_profile', if: fact('osfamily').eql?('Debian') do
    describe package('software-properties-common') do
      it { is_expected.to be_installed }
    end

    describe package('unattended-upgrades') do
      it { is_expected.to be_installed }
    end

    describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_mode 644 }
    end
  end
end
