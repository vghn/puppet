require 'rspec/core/rake_task'

require_relative 'lib/common'

# Load extra tasks
$LOAD_PATH << File.join(File.dirname(__FILE__), 'tasks')
Dir['tasks/**/*.rake'].each { |task| load task }

# Rubocop
require 'rubocop/rake_task'
desc 'Run RuboCop on the tasks and lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['tasks/**/*.rake', 'lib/**/*.rb']
end

# GitHub CHANGELOG generator
require 'github_changelog_generator/task'
GitHubChangelogGenerator::RakeTask.new(:unreleased) do |config|
  ARGV.clear
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
