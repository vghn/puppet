shared_examples 'profile::samba' do
  describe package('samba') do
    it { is_expected.to be_installed }
  end
end
