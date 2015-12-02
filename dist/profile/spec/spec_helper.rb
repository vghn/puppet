require 'puppetlabs_spec_helper/module_spec_helper'

require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  c.hiera_config = './spec/fixtures/hiera.yaml'
end

require 'simplecov'
require 'simplecov-console'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
]
SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
end
