# R10K tasks

# Local libraries
require 'common'
require 'git'
require 'release'

namespace :r10k do
  desc 'Print outdated forge modules'
  task :dependencies do
    require 'r10k/puppetfile'
    require 'puppet_forge'

    puppetfile = R10K::Puppetfile.new('.')

    puppetfile.load
    puppetfile.modules.each do |mod|
      if mod.class == R10K::Module::Forge
        module_name = mod.title.tr('/', '-')
        forge_version = PuppetForge::Module.find(module_name)
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
      elsif mod.class == R10K::Module::Git
        require 'open-uri'
        require 'json'

        # Try to extract owner and repo name from remote string
        remote = mod.instance_variable_get('@remote')
        owner  = remote.gsub(%r{(.*)\/(.*)\/(.*)}, '\\2')
        repo   = remote.gsub(%r{(.*)\/(.*)\/}, '\\3')

        # It's better to query the API authenticated because of the rate
        # limit. You can make up to 5,000 requests per hour. For unauthenticated
        # requests, the rate limit is only up to 60 requests per hour.
        # (https://developer.github.com/v3/#rate-limiting)
        tags = if ENV['GITHUB_TOKEN']
                 open("https://api.github.com/repos/#{owner}/#{repo}/tags?access_token=#{ENV['GITHUB_TOKEN']}")
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
          Gem::Version.new line['name'].gsub(/[v]?(.*)/, '\\1')
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
end
