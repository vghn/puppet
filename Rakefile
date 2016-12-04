require 'bundler/setup'
require 'rspec/core/rake_task'

# Require common functions
require_relative 'lib/common'

desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end

# List all tasks by default
task :default do
  sh 'rake -T'
end
