# Configure the load path so all dependencies in your Gemfile can be required
require 'bundler/setup'

# Output module
module Output
  # Colorize output
  module Colorize
    def colorize(color_code)
      "\e[#{color_code}m#{self}\e[0m"
    end

    def red
      colorize(31)
    end

    def green
      colorize(32)
    end

    def blue
      colorize(34)
    end

    def yellow
      colorize(33)
    end
  end

  # Add colorize to the String class
  String.include Colorize

  # Debug message
  def debug(message)
    puts "==> #{message}".green if $DEBUG
  end

  # Information message
  def info(message)
    puts "==> #{message}".green
  end

  # Warning message
  def warn(message)
    puts "==> #{message}".yellow
  end

  # Error message
  def error(message)
    puts "==> #{message}".red
  end
end # module Output

# System module
module System
  # Check if command exists
  def command?(command)
    system("command -v #{command} >/dev/null 2>&1")
  end
end # module System

# Git module
module Git
  GITHUB_TOKEN = ENV['GITHUB_TOKEN']

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
end # module Git

# Version module
module Version
  # Semantic version (from git tags)
  FULL   = (`git describe --always --tags 2>/dev/null`.chomp || '0.0.0-0-0').freeze
  LEVELS = [:major, :minor, :patch].freeze

  # Create semantic version hash
  def semver
    @semver ||= begin
      {}.tap do |h|
        h[:major], h[:minor], h[:patch], h[:rev], h[:rev_hash] = FULL[1..-1].split(/[.-]/)
      end
    end
  end

  # Increment the version number
  def bump(level)
    new_version = semver.dup
    new_version[level] = new_version[level].to_i + 1
    to_zero = LEVELS[LEVELS.index(level) + 1..LEVELS.size]
    to_zero.each { |z| new_version[z] = 0 }
    new_version
  end
end # module Version

# Tasks module
module Tasks
  require 'rake/tasklib'

  # Release tasks
  class Release < ::Rake::TaskLib
    # Include utility modules
    include Git
    include Output
    include Version

    def initialize
      define_tasks
    end

    # Configure the github_changelog_generator/task
    def changelog(config, release: nil)
      config.bug_labels         = 'Type: Bug'
      config.enhancement_labels = 'Type: Enhancement'
      config.future_release     = "v#{release}" if release
    end

    def define_tasks
      begin
        require 'github_changelog_generator/task'
        GitHubChangelogGenerator::RakeTask.new(:unreleased) do |config|
          changelog(config)
        end
      rescue LoadError
        nil # Might be in a group that is not installed
      end

      namespace :release do
        Version::LEVELS.each do |level|
          desc "Increment #{level} version"
          task level.to_sym do
            new_version = bump(level)
            release = "#{new_version[:major]}.#{new_version[:minor]}.#{new_version[:patch]}"
            release_branch = "release_v#{release.gsub(/[^0-9A-Za-z]/, '_')}"
            initial_branch = git_branch

            info 'Check if the repository is clean'
            git_clean_repo

            einfo 'Create a new release branch'
            sh "git checkout -b #{release_branch}"

            info 'Generate new changelog'
            GitHubChangelogGenerator::RakeTask.new(:latest_release) do |config|
              changelog(config, release: release)
            end
            Rake::Task['latest_release'].invoke

            info 'Push the new changes'
            sh "git commit --gpg-sign --message 'Update change log for v#{release}' CHANGELOG.md"
            sh "git push --set-upstream origin #{release_branch}"

            info 'Waiting for CI to finish'
            puts 'Waiting for CI to finish'
            sleep 5 until git_ci_status(release_branch) == 'success'

            info 'Merge release branch'
            sh "git checkout #{initial_branch}"
            sh "git merge --gpg-sign --no-ff --message 'Release v#{release}' #{release_branch}"

            info 'Tag release'
            sh "git tag --sign v#{release} --message 'Release v#{release}'"
            sh 'git push --follow-tags'
          end
        end
      end
    end # def define_tasks
  end # class Release
end # module Tasks

# Tasks module
module Tasks
  require 'rake/tasklib'

  # Release tasks
  class Puppet < ::Rake::TaskLib
    # Include utility modules
    include Git
    include Output

    require 'json'
    require 'metadata-json-lint/rake_task'
    require 'open-uri'
    require 'puppet-lint/tasks/puppet-lint'
    require 'puppet-syntax/tasks/puppet-syntax'
    require 'puppetlabs_spec_helper/rake_tasks'
    require 'yaml'

    begin
      require 'r10k/puppetfile'
    rescue LoadError
      nil # Might be in a group that is not installed
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

    def initialize
      define_tasks
    end

    def define_tasks
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
      task :puppetfile_inspect do
        check_puppetfile_versions
      end
    end # def define_tasks

    # Compose a list of exclude paths
    def exclude_paths
      @exclude_paths ||= [
        'bundle/**/*',
        'pkg/**/*',
        'tmp/**/*',
        'spec/**/*',
        'vendor/**/*',
        'modules/**/*'
      ]
    end

    def puppetfile
      @puppetfile ||= ::R10K::Puppetfile.new(pwd)
    end

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
    end # def generate_fixtures

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
            puts "#{module_name} is OUTDATED: " \
              "#{installed_version} vs #{forge_version}"
              .red
          else
            puts "#{module_name}: #{forge_version}".green
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
          tags = if Git::GITHUB_TOKEN
                   open("https://api.github.com/repos/#{owner}/#{repo}/tags?access_token=#{Git::GITHUB_TOKEN}")
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
            puts "#{mod.title}: 'master' branch (#{latest_tag})".blue
          elsif installed_version != latest_tag
            puts "#{mod.title} is OUTDATED: " \
              "#{installed_version} vs #{latest_tag}"
              .red
          else
            puts "#{mod.title}: #{latest_tag}".green
          end
        end
      end
    end # def check_puppetfile_versions
  end # class Release
end # module Tasks

# Tasks module
module Tasks
  require 'rake/tasklib'

  # Lint tasks
  class Lint < ::Rake::TaskLib
    def initialize
      define_tasks
    end

    def define_tasks
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
    end # def define_tasks

    # Compose a list of Ruby files
    def lint_files_list
      @lint_files_list ||= FileList[
        'lib/**/*.rb',
        'spec/**/*.rb',
        'Rakefile'
      ].exclude('spec/fixtures/**/*')
    end
  end # class Lint
end # module Tasks

# Tasks module
module Tasks
  require 'rake/tasklib'

  # Release tasks
  class TravisCI < ::Rake::TaskLib
    # Include utility modules
    include Output

    # Include libraries
    require 'dotenv'

    begin
      require 'travis/auto_login'
    rescue LoadError
      nil # Might be in a group that is not installed
    end

    def initialize
      define_tasks
    end

    def define_tasks
      desc 'Sync environment with TravisCI'
      task :sync_travis_env do
        info "Hello #{Travis::User.current.name}!"

        # Update environment variables
        dotenv.each do |key, value|
          info "Updating #{key}"
          env_vars.upsert(key, value, public: false)
        end

        # Remove remote environment variables
        env_vars.each do |var|
          unless dotenv.keys.include?(var.name)
            warn "Deleting #{var.name}"
            var.delete
          end
        end
      end
    end # def define_tasks

    def travis_slug
      @travis_slug ||= `git config --get travis.slug`.chomp
    end

    def env_vars
      @env_vars ||= Travis::Repository.find(travis_slug).env_vars
    end

    def dotenv
      @dotenv ||= Dotenv.load
    end
  end # class TravisCI
end # module Tasks

# Include task modules
Tasks::Release.new
Tasks::Puppet.new
Tasks::Lint.new
Tasks::TravisCI.new

# Display version
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
