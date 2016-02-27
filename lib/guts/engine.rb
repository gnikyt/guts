module Guts 
  # Guts' engine class
  class Engine < ::Rails::Engine
    # Isolate Guts routes
    isolate_namespace Guts
    
    # Autoload concerns
    config.autoload_paths += ["#{config.root}/app/concerns"]
    
    # Allow decorator usage for extending Guts
    config.to_prepare do
      Dir.glob("#{Rails.root}/app/decorators/*/guts/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
