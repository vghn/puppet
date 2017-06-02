source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gem 'vtasks', :git => 'https://github.com/vladgh/vtasks', require: false

gem 'dotenv', require: false
gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 4.0', require: false

group :test do
  gem 'metadata-json-lint', '1.1.0', require: false
  gem 'puppet-lint', require: false
  gem 'puppet-syntax', require: false
  gem 'puppetlabs_spec_helper', require: false
  gem 'reek', require: false
  gem 'rspec', require: false
  gem 'rspec-puppet', require: false
  gem 'rspec-puppet-facts', require: false
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development do
  gem 'github_changelog_generator', require: false
  gem 'guard-rake', require: false
  gem 'puppet-blacksmith', require: false
  gem 'puppet_forge', require: false
  gem 'puppet-strings', require: false
  gem 'r10k', require: false
  gem 'travis', require: false
end

group :system_tests do
  gem 'beaker', require: false
  gem 'beaker-puppet_install_helper', require: false
  gem 'beaker-rspec', require: false
end
