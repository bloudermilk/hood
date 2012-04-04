module Hood
  autoload :DSL,      "hood/dsl"
  autoload :Variable, "hood/variable"
  autoload :VERSION,  "hood/version"

  class HoodError                 < StandardError ; end
  class DslError                  < HoodError     ; end
  class InvalidOptionError        < DslError      ; end
  class DuplicateVariableError    < DslError      ; end
  class UnfulfilledVariableError  < HoodError     ; end

  class << self
    def read_file(file)
      File.open(file, "rb") { |f| f.read }
    end

    def setup!
      load_envfile
      fulfill_requirements
    end

    def load_envfile
      @builder = DSL.evaluate("Envfile")
    end

    def fulfill_requirements
      @builder.variables.each(&:fulfill!)
    end
  end
end

require "hood/railtie" if defined?(Rails)
