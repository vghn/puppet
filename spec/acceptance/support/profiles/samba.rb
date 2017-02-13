shared_examples 'profile::samba' do
  describe package('samba') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/samba/smb.conf') do
    its(:content) { is_expected.to match %r{comment = Test Share} }
    its(:content) { is_expected.to match %r{path = /data/share} }
  end
end
