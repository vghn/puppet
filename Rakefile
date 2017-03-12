# Configure the load path so all dependencies in your Gemfile can be required
require 'bundler/setup'

# Add libraries to the load path
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

# Include task modules
require 'tasks/lint'
Tasks::Lint.new(file_list:
                  FileList[
                    'lib/**/*.rb',
                    'spec/**/*.rb',
                    'Rakefile'
                  ].exclude('spec/fixtures/**/*'))
require 'tasks/puppet'
Tasks::Puppet.new(exclude_paths: [
                    'bundle/**/*',
                    'modules/**/*',
                    'pkg/**/*',
                    'spec/**/*',
                    'tmp/**/*',
                    'vendor/**/*'
                  ])
require 'tasks/release'
Tasks::Release.new
require 'tasks/travisci'
Tasks::TravisCI.new

# Display version
require 'version'
desc 'Display version'
task :version do
  puts "Current version: #{Version::FULL}"
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
