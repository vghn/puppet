require 'serverspec'

set :backend, :exec

# VARs
environment = ENV['ENVTYPE'] || 'production'
pp_envpath = '/etc/puppetlabs/code/environments'
pp_profile_dir = "#{pp_envpath}/#{environment}/dist/profile"
support_dir = "#{pp_profile_dir}/spec/acceptance/support"

# Include shared examples
Dir["#{support_dir}/**/*.rb"].sort.each { |f| require f }
