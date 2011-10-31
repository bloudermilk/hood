module Hood
  class DSL
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

    def env(name, opts={})
      _normalize_options(name, opts)

      var = Variable.new(name, opts)
    end

    def optional
      @optional, old = true, @optional
      yield
    ensure
      @optional = old
    end

    def prefix(prefix)
      @prefix, old = @prefix + prefix, @prefix
      yield
    ensure
      @prefix = old
    end

  private

    def _normalize_hash(opts)
      # Cannot modify a hash during an iteration in 1.9
      opts.keys.each do |k|
        next if String === k
        v = opts[k]
        opts.delete(k)
        opts[k.to_s] = v
      end
      opts
    end
  
    def _normalize_options(name, opts)
      _normalize_hash(opts)

      invalid_keys = opts.keys - %w(description prefix optional)
      if invalid_keys.any?
        plural = invalid_keys.size > 1
        message = "You passed #{invalid_keys.map{|k| ':'+k }.join(", ")} "
        if plural
          message << "as options for env '#{name}', but they are invalid."
        else
          message << "as an option for env '#{name}', but it is invalid."
        end
        raise InvalidOption, message
      end
    end
  end
end
