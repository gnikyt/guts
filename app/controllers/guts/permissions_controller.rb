require_dependency 'guts/application_controller'

module Guts
  # Permissions controller
  class PermissionsController < ApplicationController
    # Permits permissions from forms
    # @private
    def permission_params
      params.require(:permission).permit(:permissionable_type, :permissionable_id)
    end
  end
end
