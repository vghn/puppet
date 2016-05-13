shared_examples 'profile::aws::cloudformation' do
  describe package('aws-cfn-bootstrap') do
    it { is_expected.to be_installed.by(:pip) }
  end
end
