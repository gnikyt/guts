require_dependency 'guts/application_controller'

module Guts
  # Permissions controller
  class PermissionsController < ApplicationController
    include ControllerPermissionConcern

    before_action :set_object
    before_action :set_authorization, only: [:additional, :additional_create]
    load_and_authorize_resource

    # Displays the permissions
    def index
    end

    # Assigning a permission to an object
    def new
      @permission     = Permission.new
      @authorizations = Authorization.where(subject_id: nil)
      @grouped_auths  = @authorizations.group_by(&:subject_class)
    end

    # Creates a permission for an object
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      ActiveRecord::Base.transaction do
        # Takes the custom authorization field from the form and loops
        # and merges it into ther permission_params
        params[:authorization_ids].each do |id|
          permission = Permission.new permission_params.merge(authorization_id: id)
          permission.save!
        end
      end

      # Success, all done
      flash[:notice] = 'Permission was successfully granted.'
      redirect_to polymorphic_path([@object, :permissions])
    rescue ActiveRecord::RecordInvalid => _
      # Something did not validate
      redirect_to new_polymorphic_path([@object, :permission])
    end

    # Revokes a permission
    def destroy
      @permission = @object.permissions.find { |p| p.id == params[:id].to_i }
      @permission.destroy if @permission

      flash[:notice] = @permission ? 'Permission was revoked.' : 'Error revoking permission.'
      redirect_to polymorphic_path([@object, :permissions])
    end

    # Fine-tuned permissions on an object level
    def additional
      @permission = Permission.new
      @objects    = "#{@authorization.subject_class}".constantize.all
    end

    # Creates a permission for an object at a fine level
    # @note Redirects to #index if successfull or re-renders #additional if not
    def additional_create
      # Check if authorization exists and create if it does not
      authorization = Authorization.find_or_create_by(
        subject_class: @authorization.subject_class,
        action: @authorization.action,
        subject_id: params[:subject_id]
      ) do |auth|
        auth.description = @authorization.action
      end

      # Save the permission
      @permission = Permission.new permission_params.merge(authorization_id: authorization.id)

      if @permission.save
        # Success, all done
        flash[:notice] = 'Permission was successfully granted.'
        redirect_to polymorphic_path([@object, :permissions])
      else
        # Error
        redirect_to polymorphic_path([:additional, @object, :permissions])
      end
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

      @object = param_object.find(params[param_name])
    end

    # Grabs the authorization from query params for fine-tune permissions
    # @note This is a `before_action` callback
    # @private
    def set_authorization
      @authorization = Authorization.find params[:authorization_id]
    end

    # Permits permissions from forms
    # @private
    def permission_params
      params.require(:permission).permit(:permissionable_type, :permissionable_id)
    end
  end
end
