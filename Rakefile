# Configure the load path so all dependencies in your Gemfile can be required
require 'bundler/setup'

# Add RSpec tasks
require 'rspec/core/rake_task'

# Require common functions
require_relative 'lib/common'

# Create a list of contributors from GitHub
desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end

# List all tasks by default
task :default do
  sh 'rake -T'
end
