shared_examples 'profile::puppet::agent' do
  describe 'apt_repos', if: fact('os')['name'].eql?('Ubuntu') do
    describe file("/etc/apt/sources.list.d/apt.puppetlabs.com-#{fact('os')['distro']['codename']}.list") do
      its(:content) { is_expected.to match(%r{deb http://apt.puppetlabs.com #{fact('os')['distro']['codename']} main}) }
    end
  end

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
