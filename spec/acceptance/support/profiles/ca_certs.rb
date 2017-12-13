shared_examples 'profile::ca_certs' do
  describe file('/usr/local/share/ca-certificates') do
    it { should be_directory }
  end
end
