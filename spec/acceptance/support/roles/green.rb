shared_examples 'role::green' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::linuxfw'
  it_behaves_like 'profile::fail2ban'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::python'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::jq'
  it_behaves_like 'profile::vgs'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::docker'
end
