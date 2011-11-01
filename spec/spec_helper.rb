# Load up the test environment
Bundler.setup(:default, :test)
Bundler.require(:default, :test)

lib_path = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include? lib_path

require "hood"

require "fileutils"

# Store the unmodified ENV hash
og_env = ENV.to_hash

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:each) do
    # Reset ENV back to the way it was before the test ran
    ENV.keys.each {|k| ENV.delete(k) }
    og_env.each_pair {|k,v| ENV[k] = v }
  end
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
