require 'serverspec'

set :backend, :exec

# Include shared examples
support_dir = './dist/profile/spec/acceptance/support'
Dir["#{support_dir}/**/*.rb"].sort.each { |f| require f }
