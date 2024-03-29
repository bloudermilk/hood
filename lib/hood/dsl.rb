module Hood
  class DSL
    VALID_OPTION_KEYS = [:default, :description, :optional]

    attr_reader :variables

    def self.evaluate(envfile)
      builder = new
      builder.instance_eval(Hood.read_file(envfile.to_s), envfile.to_s, 1)
      builder
    end

    def initialize
      @variables  = []
      @optional   = false
      @prefix     = ""
    end

    def exists?(name)
      !!@variables.index {|v| v.name == name }
    end

    def env(name, opts={})
      name, opts = _normalize_options(name, opts)

      var = Variable.new(name, opts)

      if exists? var.name
        message = "You tried to define the variable '#{var.name}' twice."
        raise DuplicateVariableError, message
      end

      @variables << var

      var
    end

    def optional
      @optional, old = true, @optional
      yield
    ensure
      @optional = old
    end

    def prefix(prefix, &block)
      @prefix, old = @prefix + prefix, @prefix
      yield
    ensure
      @prefix = old
    end

  private

    def _normalize_hash(opts)
      # Cannot modify a hash during an iteration in 1.9
      opts.keys.each do |k|
        next if k.is_a? Symbol
        v = opts[k]
        opts.delete(k)
        opts[k.to_sym] = v
      end
      opts
    end
  
    def _normalize_options(name, opts)
      _normalize_hash(opts)

      invalid_keys = opts.keys - VALID_OPTION_KEYS
      if invalid_keys.any?
        plural = invalid_keys.size > 1
        message = "You passed #{invalid_keys.map{|k| ":#{k}" }.join(", ")} "
        if plural
          message << "as options for variable '#{name}', but they are invalid."
        else
          message << "as an option for variable '#{name}', but it is invalid."
        end
        raise InvalidOptionError, message
      end

      # The :optional option should default to the builder's state
      opts[:optional] = @optional if opts[:optional].nil?

      # Prepend the prefix
      name = @prefix + name

      [name, opts]
    end
  end
end
