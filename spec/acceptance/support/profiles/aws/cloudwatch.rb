shared_examples 'profile::aws::cloudwatch' do
  describe file('/etc/awslogs/awslogs.conf') do
    it { is_expected.to exist }
    its(:content) { is_expected.to match %r{/var/log/syslog} }
  end

  describe service('awslogs') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
