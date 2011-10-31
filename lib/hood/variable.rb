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
  end
end
