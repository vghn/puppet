# Configure the load path so all dependencies in your Gemfile can be required
require 'bundler/setup'

# Puppet tasks
require 'vtasks/puppet'
Vtasks::Puppet.new

desc 'Run puppet tests'
task test: ['puppet:test']

# Lint tasks
require 'vtasks/lint'
Vtasks::Lint.new(
  file_list: FileList[
    '{lib,spec}/**/*.rb',
    'Rakefile'
  ].exclude('spec/fixtures/**/*')
)

# Release tasks
require 'vtasks/release'
Vtasks::Release.new(
  write_changelog: true,
  wait_for_ci_success: true,
  bug_labels: 'Type: Bug',
  enhancement_labels: 'Type: Enhancement'
)

# Display version
desc 'Display version'
task :version do
  require 'vtasks/version'
  include Vtasks::Utils::Semver
  puts "Current version: #{gitver}"
end

# Create a list of contributors from GitHub
desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end

# List all tasks by default
Rake::Task[:default].clear if Rake::Task.task_defined?(:default)
task :default do
  system 'rake -D'
end
