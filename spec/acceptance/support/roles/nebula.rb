# Nebula Role
shared_examples 'role::nebula' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::ca_certs'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::samba'
end
