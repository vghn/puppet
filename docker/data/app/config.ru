$LOAD_PATH.unshift(File.dirname(__FILE__))
Dir.glob('./helpers/*.rb').each { |file| require file }
require 'app'
run DataAgent
