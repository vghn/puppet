shared_examples 'profile::docker' do
  virtual = command('/opt/puppetlabs/bin/facter virtual').stdout.chomp

  if virtual != 'docker'
    describe package('docker-ce') do
      it { is_expected.to be_installed }
    end

    describe service('docker') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file('/var/run/docker.sock') do
      it { is_expected.to be_socket }
    end
  end
end
