shared_examples 'profile::aws::ssm' do
  describe package('amazon-ssm-agent') do
    it { is_expected.to be_installed }
  end

  describe service('amazon-ssm-agent') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
