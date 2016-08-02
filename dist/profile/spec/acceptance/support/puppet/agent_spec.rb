shared_examples 'profile::puppet::agent' do
  describe service('puppet') do
    it { is_expected.not_to be_enabled }
    it { is_expected.not_to be_running }
  end
  describe service('mcollective') do
    it { is_expected.not_to be_enabled }
    it { is_expected.not_to be_running }
  end
  describe service('pxp-agent') do
    it { is_expected.not_to be_enabled }
    it { is_expected.not_to be_running }
  end

  describe command('sudo -u root crontab -l') do
    its(:stdout) do
      is_expected.to match(/puppet agent --onetime --no-daemonize/)
    end
  end
end
