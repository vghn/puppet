# VPI Role
shared_examples 'role::rhea' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::swap'
  it_behaves_like 'profile::ca_certs'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::python'
  it_behaves_like 'profile::jq'
  it_behaves_like 'profile::puppet::agent'
end
