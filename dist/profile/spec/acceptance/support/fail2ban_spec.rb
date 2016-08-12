shared_examples 'profile::fail2ban' do
  describe package('fail2ban') do
    it { is_expected.to be_installed }
  end
end
