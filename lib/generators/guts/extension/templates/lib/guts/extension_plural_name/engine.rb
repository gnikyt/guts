module Guts
  module <%= extension_plural_class_name %>
    class Engine < ::Rails::Engine
      isolate_namespace Guts::<%= extension_plural_class_name %>

      ExtensionRegistry.register do |e|
        e.name  = '<%= extension_plural_name %>'
        e.menus = {
          :'<%= extension_plural_name.titleize %>' => Guts::Engine.routes.url_helpers.<%= plural_name %>_path
        }
      end
    end
  end
end
