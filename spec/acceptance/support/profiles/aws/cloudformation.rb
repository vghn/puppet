shared_examples 'profile::aws::cloudformation' do
  describe package('aws-cfn-bootstrap') do
    it { is_expected.to be_installed.by(:pip) }
  end

  describe file('/usr/local/init/ubuntu/cfn-hup') do
    it { is_expected.to be_mode 440 }
  end

  describe file('/etc/init.d/cfn-hup') do
    it { is_expected.to be_linked_to '/usr/local/init/ubuntu/cfn-hup' }
  end
end
