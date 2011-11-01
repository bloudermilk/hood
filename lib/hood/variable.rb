module Hood
  class Variable
    attr_reader :name, :description, :default

    def initialize(name, opts={})
      @name         = name
      @default      = opts[:default]
      @description  = opts[:description]
      @optional     = !!opts[:optional]
    end

    def optional?
      @optional
    end

    def fulfill!
      ENV[name] ||= @default

      unless valid?
        message = "Missing required environment variable '#{name}'"
        raise UnfulfilledVariableError, message
      end
    end

    def valid?
      !!ENV[name] || optional?
    end
  end
end
