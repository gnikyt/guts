module Guts
  module <%= extension_plural_class_name %>
    class Engine < ::Rails::Engine
      isolate_namespace Guts::<%= extension_plural_class_name %>
    end
  end
end
