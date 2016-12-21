require 'rake'
require 'rake/tasklib'
require 'open-uri'
require 'yaml'
require 'json'
require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless ::Puppet.version.to_f < 3.6
require 'metadata-json-lint/rake_task'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppetlabs_spec_helper/rake_tasks'
require 'r10k/puppetfile'

begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
  nil # Not worth mentioning libs that are not installed
end

begin
  require 'puppet-strings/tasks'
rescue LoadError
  nil # Not worth mentioning libs that are not installed
end

begin
  require 'r10k/puppetfile'
rescue LoadError
  nil # Not worth mentioning libs that are not installed
end

begin
  require 'puppet_forge'
rescue LoadError
  nil # Not worth mentioning libs that are not installed
end

# Local libraries
require 'common'

module Tasks
  # Puppet tasks
  class Puppet < ::Rake::TaskLib
    attr_reader :puppetfile
    attr_reader :github_token
    attr_reader :exclude_paths

    def initialize
      @puppetfile    = ::R10K::Puppetfile.new('.')
      @github_token  = ENV['GITHUB_TOKEN']
      @exclude_paths = [
        'bundle/**/*',
        'pkg/**/*',
        'tmp/**/*',
        'spec/**/*',
        'vendor/**/*'
      ]
      define
    end

    def define
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
    end

    def generate_fixtures
      puppetfile.load
      error 'Puppetfile was not found or is empty!' if puppetfile.modules.empty?

      fixtures = {
        'fixtures' => {
          'symlinks' =>   {
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
    end

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
          tags = if github_token
                   open("https://api.github.com/repos/#{owner}/#{repo}/tags?access_token=#{github_token}")
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
  end # class Lint
end # module Tasks
