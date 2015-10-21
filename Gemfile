source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 4'
  gem 'puppet-lint'
  gem 'puppetlabs_spec_helper'
  gem 'json'
  gem 'metadata-json-lint'
  gem 'travis'
  gem 'travis-lint'
  gem 'rubocop'
end

group :system_tests do
  gem 'beaker'
  gem 'beaker-rspec'
  gem 'beaker-puppet_install_helper'
end
