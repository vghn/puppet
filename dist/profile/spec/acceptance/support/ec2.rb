shared_examples 'profile::ec2' do
  release = command('/usr/bin/lsb_release -cs').stdout.chomp
  describe file("/etc/apt/sources.list.d/git-core-ppa-#{release}.list") do
    it { is_expected.to contain 'http://ppa.launchpad.net/git-core/ppa/ubuntu' }
  end
  describe package('git') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/awslogs/awslogs.conf') do
    it { is_expected.to exist }
  end
  describe service('awslogs') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe package('aws-cfn-bootstrap') do
    it { is_expected.to be_installed.by(:pip) }
  end

  describe package('codedeploy-agent') do
    it { is_expected.to be_installed }
  end
  describe service('codedeploy-agent') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe package('amazon-ssm-agent') do
    it { is_expected.to be_installed }
  end
  describe service('amazon-ssm-agent') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe command('/usr/local/rvm/bin/rvm list') do
    its(:stdout) { is_expected.to match(/ruby-2\.2\.1/) }
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe file('/usr/local/bin/jq') do
    it { is_expected.to be_executable }
  end
end
