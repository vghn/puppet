shared_examples 'profile::ca_certs' do
  describe file('/usr/share/ca-certificates/ca_certs') do
    it { should be_directory }
  end
end
