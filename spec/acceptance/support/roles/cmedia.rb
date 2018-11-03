# CMedia Role
shared_examples 'role::cmedia' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::ca_certs'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::docker'
end
