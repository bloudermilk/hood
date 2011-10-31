# Load up the test environment
Bundler.setup(:default, :test)
Bundler.require(:default, :test)

lib_path = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include? lib_path

require "hood"

require "fileutils"

RSpec.configure do |config|
  config.mock_with :rspec
end

def in_tmp(&block)
  begin
    FileUtils.mkdir("spec/tmp")
    Dir.chdir("spec/tmp", &block)
  ensure
    FileUtils.rm_rf("spec/tmp")
  end
end

def with_envfile(contents="")
  in_tmp do
    File.open("Envfile", "w") {|f| f.puts contents }
    yield "Envfile"
  end
end
