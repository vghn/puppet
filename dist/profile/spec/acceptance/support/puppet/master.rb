shared_examples 'profile::puppet::master' do
  describe file('/etc/init/rhea.conf') do
    it { is_expected.to exist }
  end

  describe command('sudo -u root crontab -l') do
    its(:stdout) { should match(/docker run .*backup/) }
  end
end
