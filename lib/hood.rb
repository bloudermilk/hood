module Hood
  autoload :DSL,      "hood/dsl"
  autoload :Variable, "hood/variable"
  autoload :VERSION,  "hood/version"

  class HoodError     < StandardError ; end
  class DslError      < HoodError     ; end
  class InvalidOption < DslError      ; end

  class << self
    def read_file(file)
      File.open(file, "rb") { |f| f.read }
    end
  end
end
