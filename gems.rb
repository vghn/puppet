source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gem 'vtasks', require: false

gem 'dotenv', '~> 2.0', require: false
gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 6.0', require: false

group :test do
  gem 'metadata-json-lint', '~> 2.0', require: false
  gem 'puppet-lint', '~> 2.0', require: false
  gem 'puppet-syntax', '~> 2.0', require: false
  gem 'puppetlabs_spec_helper', '~> 2.0', require: false
  gem 'r10k', '~> 3.0', require: false
  gem 'reek', '~> 4.0', require: false
  gem 'rspec', '~> 3.0', require: false
  gem 'rspec-puppet', '~> 2.0', require: false
  gem 'rspec-puppet-facts', '~> 1.0', require: false
  gem 'rspec-puppet-utils', '~> 3.0', require: false
  gem 'rubocop', '~> 0.0', require: false
  gem 'rubycritic', '~> 3.0', require: false
end

group :development do
  gem 'github_changelog_generator', '~> 1.0', require: false
  gem 'guard-rake', '~> 1.0', require: false
  gem 'puppet-blacksmith', '~> 4.0', require: false
  gem 'puppet_forge', '~> 2.0', require: false
  gem 'puppet-strings', '~> 2.0', require: false
end

group :system_tests do
  gem 'beaker', '~> 4.0', require: false
  gem 'beaker-puppet', '~> 1.0', require: false
  gem 'beaker-docker', '~> 0.0', require: false
  gem 'beaker-hiera', '~> 0.0', require: false
  gem 'beaker-hostgenerator', '~> 1.0', require: false
  gem 'beaker-puppet_install_helper', '~> 0.0', require: false
  gem 'beaker-module_install_helper', '~> 0.0', require: false
  gem 'beaker-rspec', '~> 6.0', require: false
  gem 'beaker-vagrant', '~> 0.0', require: false
  # SSH ED25519 support
  gem 'bcrypt_pbkdf', '~> 1.0', require: false
  gem 'rbnacl', '~> 4.0', require: false
  gem 'rbnacl-libsodium', '~> 1.0', require: false
end
