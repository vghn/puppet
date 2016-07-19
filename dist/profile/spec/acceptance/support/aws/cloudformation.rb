shared_examples 'profile::aws::cloudformation' do
  describe package('aws-cfn-bootstrap') do
    it { is_expected.to be_installed.by(:pip) }
  end
  describe service('cfn-hup') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
