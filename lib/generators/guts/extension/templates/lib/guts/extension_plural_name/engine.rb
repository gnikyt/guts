module Guts
  module <%= extension_plural_class_name %>
    class Engine < ::Rails::Engine
      isolate_namespace Guts::<%= extension_plural_class_name %>

      ExtensionRegistry.register do |e|
        e.name       = '<%= extension_plural_name %>'
        e.menu_items = [{
          '<%= extension_plural_name.titleize %>': 
        }]
      end
    end
  end
end
