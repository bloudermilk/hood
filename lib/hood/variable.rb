module Hood
  class Variable
    def initialize(name, opts={})
      @name         = name
      @description  = opts[:description]
      @optional     = !!opts[:optional]
    end
  end
end
