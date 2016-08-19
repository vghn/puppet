desc 'Display version'
task :version do
  puts "Current version: #{`git describe --always --tags`}"
end

LEVELS = [:major, :minor, :patch].freeze
namespace :version do
  LEVELS.each do |level|
    desc "Increment #{level} version"
    task level.to_sym do
      v = increment(level)
      release = "#{v[:major]}.#{v[:minor]}.#{v[:patch]}"

      GitHubChangelogGenerator::RakeTask.new(:latest_release) do |config|
        configure_changelog(config, release: release)
      end

      Rake::Task['latest_release'].invoke
      sh "git commit --gpg-sign --message 'Release v#{release}'"
      Rake::Task['version:set'].invoke(v[:major], v[:minor], v[:patch])
    end
  end

  desc 'Set specific major, minor and patch'
  task :set, [:release] do |_, args|
    sh "git tag --sign v#{args[:release]} --message 'Release v#{args[:release]}'"
    sh "git push --tags"
  end
end
