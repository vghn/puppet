# Configure the load path so all dependencies in your Gemfile can be required
require 'bundler/setup'

# VARs
GITHUB_TOKEN = ENV['GITHUB_TOKEN']

# Semantic version (from git tags)
VERSION = (`git describe --always --tags 2>/dev/null`.chomp || '0.0.0-0-0').freeze
LEVELS  = [:major, :minor, :patch].freeze

require 'rainbow'

# Debug message
def debug(message)
  puts Rainbow("==> #{message}").green if $DEBUG
end

# Information message
def info(message)
  puts Rainbow("==> #{message}").green
end

# Warning message
def warn(message)
  puts Rainbow("==> #{message}").yellow
end

# Error message
def error(message)
  puts Rainbow("==> #{message}").red
end

# Check if command exists
def command?(command)
  system("command -v #{command} >/dev/null 2>&1")
end

# Compose a list of Ruby files
def lint_files_list
  @lint_files_list = FileList[
    'lib/**/*.rb',
    'spec/**/*.rb',
    'Rakefile'
  ].exclude('spec/fixtures/**/*')
end

def exclude_paths
  @exclude_paths ||= [
    'bundle/**/*',
    'pkg/**/*',
    'tmp/**/*',
    'spec/**/*',
    'vendor/**/*'
  ]
end

def version_hash
  @version_hash ||= begin
    {}.tap do |h|
      h[:major], h[:minor], h[:patch], h[:rev], h[:rev_hash] = VERSION[1..-1].split(/[.-]/)
    end
  end
end

# Increment the version number
def version_bump(level)
  new_version = version_hash.dup
  new_version[level] = new_version[level].to_i + 1
  to_zero = LEVELS[LEVELS.index(level) + 1..LEVELS.size]
  to_zero.each { |z| new_version[z] = 0 }
  new_version
end

# Get git short commit hash
def git_commit
  `git rev-parse --short HEAD`.strip
end

# Get the branch name
def git_branch
  return ENV['GIT_BRANCH'] if ENV['GIT_BRANCH']
  return ENV['TRAVIS_BRANCH'] if ENV['TRAVIS_BRANCH']
  return ENV['CIRCLE_BRANCH'] if ENV['CIRCLE_BRANCH']
  `git symbolic-ref HEAD --short 2>/dev/null`.strip
end

# Get the URL of the origin remote
def git_url
  `git config --get remote.origin.url`.strip
end

# Get the CI Status (needs https://hub.github.com/)
def git_ci_status(branch = 'master')
  `hub ci-status #{branch}`.strip
end

# Check if the repo is clean
def git_clean_repo
  # Check if there are uncommitted changes
  unless system 'git diff --quiet HEAD'
    abort('ERROR: Commit your changes first.')
  end

  # Check if there are untracked files
  unless `git ls-files --others --exclude-standard`.to_s.empty?
    abort('ERROR: There are untracked files.')
  end

  true
end

# Configure the github_changelog_generator/task
def changelog(config, release: nil)
  config.bug_labels         = 'Type: Bug'
  config.enhancement_labels = 'Type: Enhancement'
  config.future_release     = "v#{release}" if release
end

begin
  require 'r10k/puppetfile'
rescue LoadError
  nil # Might be in a group that is not installed
end

def puppetfile
  @puppetfile ||= ::R10K::Puppetfile.new(pwd)
end

require 'yaml'

def generate_fixtures
  info 'Generating fixtures file'

  puppetfile.load
  error 'Puppetfile was not found or is empty!' if puppetfile.modules.empty?

  fixtures = {
    'fixtures' => {
      'symlinks' => {
        'role' => '#{source_dir}/dist/role',
        'profile' => '#{source_dir}/dist/profile'
      },
      'repositories' => {}
    }
  }

  puppetfile.modules.each do |mod|
    module_name = mod.title.tr('/', '-')
    remote      = mod.instance_variable_get('@remote')
    ref         = mod.instance_variable_get('@desired_ref')

    fixtures['fixtures']['repositories'][module_name] = {
      'repo' => remote,
      'ref' => ref
    }
  end

  File.open('.fixtures.yml', 'w') { |file| file.write(fixtures.to_yaml) }
  info 'Done'
end

require 'json'
require 'open-uri'
require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless ::Puppet.version.to_f < 3.6

def check_puppetfile_versions
  puppetfile.load
  error 'Puppetfile was not found or is empty!' if puppetfile.modules.empty?

  puppetfile.modules.each do |mod|
    if mod.class == ::R10K::Module::Forge
      module_name = mod.title.tr('/', '-')
      forge_version = ::PuppetForge::Module.find(module_name)
                                           .current_release.version
      installed_version = mod.expected_version
      if installed_version != forge_version
        puts Rainbow(
          "#{module_name} is OUTDATED: " \
          "#{installed_version} vs #{forge_version}"
        ).red
      else
        puts Rainbow("#{module_name}: #{forge_version}").green
      end
    elsif mod.class == ::R10K::Module::Git
      # Try to extract owner and repo name from remote string
      remote = mod.instance_variable_get('@remote')
      owner  = remote.gsub(%r{(.*)\/(.*)\/(.*)}, '\\2')
      repo   = remote.gsub(%r{(.*)\/(.*)\/}, '\\3')

      # It's better to query the API authenticated because of the rate
      # limit. You can make up to 5,000 requests per hour. For unauthenticated
      # requests, the rate limit is only up to 60 requests per hour.
      # (https://developer.github.com/v3/#rate-limiting)
      tags = if GITHUB_TOKEN
               open("https://api.github.com/repos/#{owner}/#{repo}/tags?access_token=#{GITHUB_TOKEN}")
             else
               open("https://api.github.com/repos/#{owner}/#{repo}/tags")
             end

      # Get rid of non-semantic versions (for example
      # https://github.com/puppetlabs/puppetlabs-ntp/releases/tag/push)
      all_tags = JSON.parse(tags.read).select do |tag|
        tag['name'] =~ /v?\d+\.\d+\.\d+/
      end

      # Use Gem::Version to sort tags
      latest_tag = all_tags.map do |line|
        ::Gem::Version.new line['name'].gsub(/[v]?(.*)/, '\\1')
      end.max.to_s

      # Print results
      installed_version = mod.version.gsub(/[v]?(.*)/, '\\1')
      if installed_version == 'master'
        puts Rainbow("#{mod.title}: 'master' branch (#{latest_tag})").blue
      elsif installed_version != latest_tag
        puts Rainbow(
          "#{mod.title} is OUTDATED: " \
          "#{installed_version} vs #{latest_tag}"
        ).red
      else
        puts Rainbow("#{mod.title}: #{latest_tag}").green
      end
    end
  end
end

begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
  nil # Might be in a group that is not installed
end

begin
  require 'puppet-strings/tasks'
rescue LoadError
  nil # Might be in a group that is not installed
end

begin
  require 'puppet_forge'
rescue LoadError
  nil # Might be in a group that is not installed
end

require 'metadata-json-lint/rake_task'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppetlabs_spec_helper/rake_tasks'

# Must clear as it will not override the existing puppet-lint rake task
::Rake::Task[:lint].clear
::Rake::Task[:rubocop].clear
::PuppetLint::RakeTask.new :lint do |config|
  config.relative = true
  config.with_context = true
  config.fail_on_warnings = true
  config.ignore_paths = exclude_paths
  config.disable_checks = [
    '140chars'
  ]
end

# Puppet syntax tasks
::PuppetSyntax.exclude_paths = exclude_paths

desc 'Run syntax, lint, and spec tests.'
task test: [
  :metadata_lint,
  :syntax,
  :lint,
  :spec_prep,
  :spec_standalone
]

desc 'Run acceptance tests.'
task integration: [
  :spec_prep,
  :beaker
]

desc 'Clean all test files.'
task clean: [:spec_clean]

desc 'Generates a new .fixtures.yml from a Puppetfile.'
task :generate_fixtures do
  generate_fixtures
end

desc 'Print outdated Puppetfile modules.'
task :check_puppetfile_versions do
  check_puppetfile_versions
end

# RuboCop
require 'rubocop/rake_task'
desc 'Run RuboCop on the tasks and lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = lint_files_list
  task.options  = ['--display-cop-names', '--extra-details']
end

# Reek
require 'reek/rake/task'
Reek::Rake::Task.new do |task|
  task.source_files  = lint_files_list
  task.fail_on_error = false
  task.reek_opts     = '--wiki-links --color'
end

# Ruby Critic
require 'rubycritic/rake_task'
RubyCritic::RakeTask.new do |task|
  task.paths = lint_files_list
end

begin
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new(:unreleased) do |config|
    changelog(config)
  end
rescue LoadError
  nil # Might be in a group that is not installed
end

namespace :release do
  LEVELS.each do |level|
    desc "Increment #{level} version"
    task level.to_sym do
      new_version = version_bump(level)
      release = "#{new_version[:major]}.#{new_version[:minor]}.#{new_version[:patch]}"
      release_branch = "release_v#{release.gsub(/[^0-9A-Za-z]/, '_')}"
      initial_branch = git_branch

      # Check if the repo is clean
      git_clean_repo

      # Create a new release branch
      sh "git checkout -b #{release_branch}"

      # Generate new changelog
      GitHubChangelogGenerator::RakeTask.new(:latest_release) do |config|
        changelog(config, release: release)
      end
      Rake::Task['latest_release'].invoke

      # Push the new changes
      sh "git commit --gpg-sign --message 'Release v#{release}' CHANGELOG.md"
      sh "git push --set-upstream origin #{release_branch}"

      # Waiting for CI to finish
      puts 'Waiting for CI to finish'
      sleep 5 until git_ci_status(release_branch) == 'success'

      # Merge release branch
      sh "git checkout #{initial_branch}"
      sh "git merge --gpg-sign --no-ff --message 'Release v#{release}' #{release_branch}"

      # Tag release
      sh "git tag --sign v#{release} --message 'Release v#{release}'"
      sh 'git push --follow-tags'
    end
  end
end

# Display version
desc 'Display version'
task :version do
  puts "Current version: #{VERSION}"
end

# Create a list of contributors from GitHub
desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end

# List all tasks by default
Rake::Task[:default].clear if Rake::Task.task_defined?(:default)
task :default do
  puts `rake -T`
end
