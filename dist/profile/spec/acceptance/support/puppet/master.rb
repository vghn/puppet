shared_examples 'profile::puppet::master' do
  describe file('/etc/init/rhea.conf') do
    it { is_expected.to exist }
  end
end
