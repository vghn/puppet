require 'bundler/setup'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless Puppet.version.to_f < 3.6
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'
require 'rspec/core/rake_task'

require_relative 'lib/common'

# These gems aren't always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

# RuboCop
require 'rubocop/rake_task'
desc 'Run RuboCop on the tasks and lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = FileList['{lib,rakelib}/**/*.{rb,rake}']
end

# Reek
require 'reek/rake/task'
Reek::Rake::Task.new do |task|
  task.source_files  = FileList['{lib,rakelib}/**/*.{rb,rake}']
  task.fail_on_error = false
  task.reek_opts     = '-U'
end

# Ruby Critic
require 'rubycritic/rake_task'
RubyCritic::RakeTask.new do |task|
  task.paths = FileList['{lib,rakelib}/**/*.{rb,rake}']
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
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.relative = true
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.disable_checks = ['140chars']
end

PuppetSyntax.exclude_paths = exclude_paths

# GitHub CHANGELOG generator
require 'github_changelog_generator/task'
GitHubChangelogGenerator::RakeTask.new(:unreleased) do |config|
  configure_changelog(config)
end

desc 'Display version'
task :version do
  puts "Current version: #{version}"
end

# List all tasks by default
task :default do
  puts `rake -T`
end

desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end

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
