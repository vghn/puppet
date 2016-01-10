require 'spec_helper_acceptance'

shared_examples 'profile::vm' do
  os_name = command('/opt/puppetlabs/bin/facter os.name').stdout.chomp

  case os_name
  when 'Ubuntu'
    describe package('vim-gnome') { it { is_expected.to be_installed } }
  else
    describe package('vim') { it { is_expected.to be_installed } }
  end

  describe package('tmux') { it { is_expected.to be_installed } }
  describe package('python-pip') { it { is_expected.to be_installed } }
end
