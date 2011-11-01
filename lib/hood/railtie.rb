module Hood
  class Railtie < Rails::Railtie
    config.to_prepare do
      Hood.setup!
    end
  end
end
