shared_examples 'profile::puppet::agent' do
  services = %w(mcollective puppet pxp-agent)
  services.each do |srv|
    describe service(srv) do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end
  end

  describe command('sudo -u root crontab -l') do
    its(:stdout) do
      is_expected.to match(/puppet agent --onetime --no-daemonize/)
    end
  end
end
