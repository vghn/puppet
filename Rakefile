$LOAD_PATH << File.join(File.dirname(__FILE__), 'tasks')
Dir['tasks/**/*.rake'].each { |task| load task }

# List all tasks by default
task :default do
  puts `rake -T`
end
