desc "Display version"
task :version do
  puts "Current version: #{`git describe --always --tags`}"
end

LEVELS = [:major, :minor, :patch]
namespace :version do
  LEVELS.each do |level|
    desc "Increment #{level} version"
    task level.to_sym do increment(level.to_sym) end
  end

  desc "Set specific major, minor and patch"
  task :set, [:major, :minor, :patch] do |_, args|
    sh "git tag v#{args[:major]}.#{args[:minor]}.#{args[:patch]} && git push --tags"
  end
end
