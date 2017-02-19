shared_examples 'profile::samba' do
  describe package('samba') do
    it { is_expected.to be_installed }
  end

  describe group('sambashare') do
    it { is_expected.to exist }
  end

  describe file('/data/test_share') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 775 }
    it { is_expected.to be_grouped_into 'sambashare' }
  end

  describe file('/etc/samba/smb.conf') do
    its(:content) { is_expected.to match(/comment = Test Share/) }
    its(:content) { is_expected.to match %r{path = /data/test_share} }
  end
end
