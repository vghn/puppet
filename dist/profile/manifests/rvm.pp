# RVM Profile
class profile::rvm {
  # Ruby Version Manager
  class { '::rvm': }
  # Binaries available at https://rvm.io/binaries
  $rvm_system_ruby = hiera('rvm_system_ruby')
  rvm_system_ruby {$rvm_system_ruby:
    ensure      => 'present',
    default_use => true,
    build_opts  => ['--binary'];
  }
}
