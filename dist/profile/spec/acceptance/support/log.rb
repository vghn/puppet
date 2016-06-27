shared_examples 'profile::base' do
  describe package('rsyslog') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/rsyslog.d/testing.conf') do
    its(:content) { should match %r{InputFileName /var/log/test.log} }
  end
end
