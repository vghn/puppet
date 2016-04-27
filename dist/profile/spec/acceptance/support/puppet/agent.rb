shared_examples 'profile::puppet::agent' do
  describe service('puppet') do
    it { is_expected.not_to be_enabled }
    it { is_expected.not_to be_running }
  end

  describe command('sudo -u root crontab -l') do
    its(:stdout) { should match(/puppet agent --onetime --no-daemonize/) }
  end
end
