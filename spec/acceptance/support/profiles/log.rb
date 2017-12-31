shared_examples 'profile::log' do
  describe package('rsyslog') do
    it { is_expected.to be_installed }
  end

  describe service('rsyslog') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe file('/etc/rsyslog.d/00_server.conf') do
    its(:content) { is_expected.to match %r{UDPServerRun} }
    its(:content) { is_expected.not_to match %r{InputTCPServerRun} }
    its(:content) { is_expected.not_to match %r{InputRELPServerRun} }
  end

  describe file('/etc/rsyslog.d/testing.conf') do
    its(:content) { is_expected.to match %r{InputFileName /var/log/test.log} }
  end
end
