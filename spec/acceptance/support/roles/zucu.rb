# Zucu Role
shared_examples 'role::zucu' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::ca_certs'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::monitor'
  it_behaves_like 'profile::python'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::jq'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::docker'
end
