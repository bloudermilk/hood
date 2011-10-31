# Load up the test environment
Bundler.setup(:default, :test)
Bundler.require(:default, :test)

lib_path = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include? lib_path

require "hood"

RSpec.configure do |config|
  config.mock_with :rspec
end
