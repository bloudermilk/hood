$LOAD_PATH.unshift "lib"

require "hood/version"

Gem::Specification.new do |s|
  s.name        = "hood"
  s.version     = Hood::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brendan Loudermilk"]
  s.email       = ["brendan@gophilosophie.com"]
  s.homepage    = "http://github.com/bloudermilk/hood"
  s.summary     = "Hood is the easiest way to manage your applications environment variables."
  s.description = "Hood gives you a standard way to define environment variable requirements for your app."

  s.files         = Dir.glob("lib/**/*") + %w(HISTORY.md LICENSE Rakefile README.md)
  s.require_path  = "lib"
end
