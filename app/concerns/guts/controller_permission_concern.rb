module Guts
  # Controller concern for permissionable controllers with CanCanCan
  module ControllerPermissionConcern
    extend ActiveSupport::Concern

    included do
      # Defines the permission name for this controller
      def self.permission
        "Guts::#{controller_name.classify}".constantize
      end
    end
  end
end
