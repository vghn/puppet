# RVM Profile
class profile::rvm(String $system_ruby) {
  # Ruby Version Manager
  class { '::rvm': }

  rvm_system_ruby {$system_ruby:
    ensure      => 'present',
    default_use => true,
    build_opts  => ['--binary'];
  }
}
