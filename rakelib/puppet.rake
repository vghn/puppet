# Puppet Rake Tasks

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless Puppet.version.to_f < 3.6
require 'metadata-json-lint/rake_task'

# `puppetlabs_spec_helper/rake_tasks` adds a default task so ours runs twice
Rake::Task[:default].clear

# Might not be always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError # rubocop:disable Lint/HandleExceptions
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
PuppetLint::RakeTask.new :lint do |config|
  config.relative = true
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.disable_checks = ['140chars']
end

require 'puppet-syntax/tasks/puppet-syntax'
PuppetSyntax.exclude_paths = exclude_paths

desc 'Run syntax, lint, and spec tests.'
task test: [
  :metadata_lint,
  :syntax,
  :lint,
  :rubocop,
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
