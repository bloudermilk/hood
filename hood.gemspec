$LOAD_PATH.unshift "lib"

require "hood/version"

Gem::Specification.new do |s|
  s.name        = "hood"
  s.version     = Hood::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brendan Loudermilk"]
  s.email       = ["brendan@gophilosophie.com"]
  s.homepage    = "http://github.com/bloudermilk/hood"
  s.summary     = "Summary has not been written yet"
  s.description = "Description has not been written yet."

  s.files         = Dir.glob("lib/**/*") + %w(LICENSE Rakefile README.md)
  s.require_path  = "lib"
end
