require 'rspec/core/rake_task'

require_relative 'lib/common'

$LOAD_PATH << File.join(File.dirname(__FILE__), 'tasks')
Dir['tasks/**/*.rake'].each { |task| load task }

require 'rubocop/rake_task'
desc 'Run RuboCop on the tasks and lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['tasks/**/*.rake', 'lib/**/*.rb']
end

# List all tasks by default
task :default do
  puts `rake -T`
end
