# Lint tasks

# Compose a list of Ruby files
ruby_files = FileList[
  'lib/**/*.rb',
  'lib/tasks/**/*.rake',
  'spec/**/*.rb',
  'Rakefile'
].exclude('spec/fixtures/**/*')

# RuboCop
require 'rubocop/rake_task'
desc 'Run RuboCop on the tasks and lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ruby_files
end

# Reek
require 'reek/rake/task'
Reek::Rake::Task.new do |task|
  task.source_files = ruby_files
  task.fail_on_error = false
  task.reek_opts     = '-U'
end

# Ruby Critic
require 'rubycritic/rake_task'
RubyCritic::RakeTask.new do |task|
  task.paths = ruby_files
end
