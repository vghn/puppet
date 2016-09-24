require 'rspec/core/rake_task'

require_relative 'lib/common'

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
