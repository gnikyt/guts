require_dependency 'guts/application_controller'

module Guts
  # Permissions controller
  class PermissionsController < ApplicationController
    before_action :set_object

    # Displays the permissions for an object
    def index; end

    # Assigning a permission to an object
    def new
      @permission = Permission.new
      authorize @permission

      # Load ApplicationPolicy first to get defaults
      standard_grants = grant_methods Guts::ApplicationPolicy
      
      # Loop over all policies
      @policies = {}
      Dir.new("#{Guts::Engine.root}/app/policies/guts")
         .entries
         .select { |file| file =~ /_policy/ }
         .each do |file|
           # Skip application policy since we completed that one
           next if file =~ /application_policy/

           # Get resource name, merge grants with standard grants
           resource = file.gsub('_policy.rb', '')
           grants   = standard_grants | grant_methods("Guts::#{file.camelize.gsub('.rb', '')}".constantize)

           @policies[resource] = grants
         end
    end

    # Creates a permission for an object
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      authorize Permission, :create?

      ActiveRecord::Base.transaction do
        # Takes the custom grants field from the form and loops
        # and merges it into ther permission_params
        params.fetch(:grants, {}).each do |resource, grants|
          grants.each do |grant|
            Permission.new(
              permission_params.merge(
                resource: resource,
                grant: grant
              )
            ).save!
          end
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

    # Permits permissions from forms
    # @private
    def permission_params
      params.require(:permission).permit(:permissionable_type, :permissionable_id)
    end

    # Grabs only instance methods which are grant methods
    # @param [Class] klass the class to check
    # @return [Array] all grant methods
    def grant_methods(klass)
      klass.instance_methods(false)
           .select { |method| method.to_s.end_with? '?' }
           .map { |method| method[0...-1] }
    end
  end
end
