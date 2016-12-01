require_dependency 'guts/application_controller'

module Guts
  # Permissions controller
  class PermissionsController < ApplicationController
    include ControllerPermissionConcern

    before_action :set_object
    load_and_authorize_resource

    # Displays the permissions
    def index
    end

    # Assigning a permission to an object
    def new
      @permission     = Permission.new
      @authorizations = Authorization.all
      @grouped_auths  = @authorizations.group_by(&:subject_class)
    end

    # Creates a permission for an object
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      begin
        ActiveRecord::Base.transaction do
          # Takes the custom authorization field from the form and loops
          # and merges it into ther permission_params
          params[:authorization_ids].each do |id|
            @permission = Permission.new permission_params.merge(authorization_id: id)
            @permission.save!
          end
        end

        # Success, all done
        flash[:notice] = 'Permission was successfully granted.'
        redirect_to polymorphic_path([@object, :permissions])
      rescue ActiveRecord::RecordInvalid => invalid
        # Something did not validate
        render :new
      end
    end

    # Revokes a permission
    def destroy
      permission = @object.permissions.find { |p| p.id == params[:id].to_i }
      permission.destroy if permission

      flash[:notice] = permission ? 'Permission was revoked.' : 'Error revoking permission.'
      redirect_to polymorphic_path([@object, :permissions])
    end

    private

    # Determines the polymorphic object if available
    # @note This is a `before_action` callback
    # @private
    def set_object
      permissionable_type = params[:permissionable_type]

      return nil if permissionable_type.nil?

      param_name   = "#{permissionable_type.demodulize.underscore}_id"
      param_object = permissionable_type.constantize
      finder       = param_object.respond_to?(:friendly) ? param_object.friendly : param_object

      @object = finder.find(params[param_name])
    end

    # Permits permissions from forms
    # @private
    def permission_params
      params.require(:permission).permit(:permissionable_type, :permissionable_id)
    end
  end
end
