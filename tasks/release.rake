namespace :release do
  LEVELS = [:major, :minor, :patch].freeze
  LEVELS.each do |level|
    desc "Increment #{level} version"
    task level.to_sym do
      v       = increment_version(level)
      release = "#{v[:major]}.#{v[:minor]}.#{v[:patch]}"

      GitHubChangelogGenerator::RakeTask.new(:latest_release) do |config|
        configure_changelog(config, release: release)
      end
      Rake::Task['latest_release'].invoke
      sh "git commit --gpg-sign --message 'Update changelog' CHANGELOG.md"

      sh "git tag --sign v#{args[:version]} --message 'Release v#{args[:version]}'"
      sh "git push --follow-tags"
    end
  end
end
