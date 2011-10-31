require "bundler"
Bundler.setup

require "rake"
require "rspec"
require "rspec/core/rake_task"

lib_path = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include? lib_path

require "hood/version"

RSpec::Core::RakeTask.new("spec")
task :default => :spec

task :build do
  system "gem build hood.gemspec"
end

task :install => :build do
  system "gem install hood-#{Hood::VERSION}.gem"
end
