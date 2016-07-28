namespace :r10k do
  desc 'Print outdated forge modules'
  task :dependencies do
    require 'r10k/puppetfile'
    require 'puppet_forge'

    puppetfile = R10K::Puppetfile.new('.').load

    puppetfile.each do |puppet_module|
      next unless puppet_module.class == R10K::Module::Forge
      module_name = puppet_module.title.tr('/', '-')
      forge_version = PuppetForge::Module.find(module_name)
                                         .current_release.version
      installed_version = puppet_module.expected_version
      if installed_version != forge_version
        puts "#{puppet_module.title} is OUTDATED: " \
             "#{installed_version} vs #{forge_version}".red
      else
        puts "#{puppet_module.title}: #{forge_version}".green
      end
    end
  end
end
