shared_examples 'profile::aws::cloudwatch' do
  describe file('/etc/awslogs/awslogs.conf') do
    it { is_expected.to exist }
  end
  describe service('awslogs') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
