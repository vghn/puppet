source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gem 'vtasks', :git => 'https://github.com/vladgh/vtasks', require: false

gem 'dotenv', '~> 2.0', require: false
gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 5.0', require: false

group :test do
  gem 'metadata-json-lint', '~> 2.0', require: false
  gem 'puppet-lint', '~> 2.0', require: false
  gem 'puppet-syntax', '~> 2.0', require: false
  gem 'puppetlabs_spec_helper', '~> 2.0', require: false
  gem 'r10k', '~> 2.0', require: false
  gem 'reek', '~> 4.0', require: false
  gem 'rspec', '~> 3.0', require: false
  gem 'rspec-puppet', '~> 2.0', require: false
  gem 'rspec-puppet-facts', '~> 1.0', require: false
  gem 'rubocop', '~> 0.0', require: false
  gem 'rubycritic', '~> 3.0', require: false
end

group :development do
  gem 'github_changelog_generator', '~> 1.0', require: false
  gem 'guard-rake', '~> 1.0', require: false
  gem 'puppet-blacksmith', '~> 3.0', require: false
  gem 'puppet_forge', '~> 2.0', require: false
  gem 'puppet-strings', '~> 1.0', require: false
end

group :system_tests do
  gem 'beaker', '~> 3.0', require: false
  gem 'beaker-puppet_install_helper', '~> 0.0', require: false
  gem 'beaker-rspec', '~> 6.0', require: false
end
