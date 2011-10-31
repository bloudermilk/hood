module Hood
  class Variable
    attr_reader :name, :description

    def initialize(name, opts={})
      @name         = name
      @description  = opts[:description]
      @optional     = !!opts[:optional]
    end

    def optional?
      @optional
    end
  end
end
