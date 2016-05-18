shared_examples 'profile::docker' do
  virtual = command('/opt/puppetlabs/bin/facter virtual').stdout.chomp

  if virtual != 'docker'
    describe package('docker-engine') do
      it { is_expected.to be_installed }
    end
    describe service('docker') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
    describe port(2375) do
      it { is_expected.to be_listening }
    end
    describe file('/var/run/docker.sock') do
      it { is_expected.to be_socket }
    end
    describe file('/usr/local/bin/docker-compose') do
      it { is_expected.to be_executable }
    end
    describe file('/usr/local/bin/docker-machine') do
      it { is_expected.to be_executable }
    end

    describe docker_image('busybox:latest') do
      it { should exist }
    end
    describe docker_container('test') do
      it { should exist }
      it { should be_running }
    end
  end
end
