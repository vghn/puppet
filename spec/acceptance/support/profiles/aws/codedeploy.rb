shared_examples 'profile::aws::codedeploy' do
  describe package('codedeploy-agent') do
    it { is_expected.to be_installed }
  end

  describe service('codedeploy-agent') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
