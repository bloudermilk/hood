module Hood
  autoload :DSL,      "hood/dsl"
  autoload :Variable, "hood/variable"
  autoload :VERSION,  "hood/version"

  class HoodError < StandardError
    def self.status_code(code)
      define_method(:status_code) { code }
    end
  end

  class DslError      < HoodError; status_code(3) ; end
  class InvalidOption < DslError                  ; end

  class << self
    def read_file(file)
      File.open(file, "rb") { |f| f.read }
    end
  end
end
