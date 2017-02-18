shared_examples 'profile::misc' do
  describe file('/etc/systemd/logind.conf') do
    its(:content) { is_expected.to match(/^HandleLidSwitch=ignore$/) }
  end
end
