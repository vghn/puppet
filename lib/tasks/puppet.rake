# Puppet tasks

# Local libraries
require 'common'
require 'git'
require 'release'

# RSpec tasks
require 'rspec/core/rake_task'

# Puppet Rake Tasks
require 'puppetlabs_spec_helper/rake_tasks'

# Fixes
# `puppetlabs_spec_helper/rake_tasks` adds a default task so ours runs twice
Rake::Task[:default].clear
# List all tasks by default
task :default do
  puts `rake -T`
end

require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless Puppet.version.to_f < 3.6
require 'metadata-json-lint/rake_task'

# Might not be always present, for example with
# `bundle install --without development`
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
  warn 'puppet_blacksmith gem is not installed'
end

# Exclude paths
exclude_paths = [
  'bundle/**/*',
  'pkg/**/*',
  'tmp/**/*',
  'spec/**/*',
  'vendor/**/*'
]

# Must clear as it will not override the existing puppet-lint rake task
require 'puppet-lint/tasks/puppet-lint'
Rake::Task[:lint].clear
Rake::Task[:rubocop].clear
PuppetLint::RakeTask.new :lint do |config|
  config.relative = true
  config.with_context = true
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.disable_checks = ['140chars']
end

# Puppet syntax tasks
require 'puppet-syntax/tasks/puppet-syntax'
PuppetSyntax.exclude_paths = exclude_paths

# Puppet Strings
# # Might not be always present, for example with
# `bundle install --without development`
begin
  require 'puppet-strings/tasks'
rescue LoadError
  warn 'puppet-strings gem is not installed'
end

desc 'Run syntax, lint, and spec tests.'
task test: [
  :metadata_lint,
  :syntax,
  :lint,
  :spec_prep,
  :spec_standalone
]

desc 'Run acceptance tests.'
task integration: [
  :spec_prep,
  :beaker
]

desc 'Clean all test files.'
task clean: [:spec_clean]
