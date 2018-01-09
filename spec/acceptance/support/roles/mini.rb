shared_examples 'role::mini' do
  it_behaves_like 'profile::base'
  it_behaves_like 'profile::vgs'
  it_behaves_like 'profile::dotfiles'
  it_behaves_like 'profile::ca_certs'
  it_behaves_like 'profile::log'
  it_behaves_like 'profile::git'
  it_behaves_like 'profile::puppet::agent'
  it_behaves_like 'profile::docker_vgh'
  it_behaves_like 'profile::docker'
  it_behaves_like 'profile::samba'
end
