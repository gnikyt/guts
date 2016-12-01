require_dependency 'guts/application_controller'

module Guts
  # Metafields controller
  class MetafieldsController < ApplicationController
    include ControllerPermissionConcern

    before_action :set_object
    before_action :set_metafield, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

    # Displays a list of metafields
    def index
      @metafields = @object.metafields
    end

    # Creation of a new metafield
    def new
      @metafield = Metafield.new
    end

    # Creates a metafield through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @metafield = Metafield.new metafield_params

      if @metafield.save
        flash[:notice] = 'Metafield was successfully created.'
        redirect_to edit_polymorphic_path([@object, @metafield])
      else
        render :new
      end
    end

    # Shows details about a single metafield
    def show
    end


    # Editing of a metafield
    def edit
    end

    # Updates a metafields through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @metafield.update metafield_params
        flash[:notice] = 'Metafield was successfully updated.'
        redirect_to edit_polymorphic_path([@object, @metafield])
      else
        render :edit
      end
    end

    # Destroys a single metafield
    # @note Redirects to #index on success
    def destroy
      @metafield.destroy

      flash[:notice] = 'Metafield was successfully destroyed.'
      redirect_to polymorphic_path([@object, :metafields])
    end

    private

    # Sets a metafield from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_metafield
      @metafield = Metafield.find params[:id]
    end

    # Determines the polymorphic object
    # @private
    def set_object
      fieldable_type = params[:fieldable_type]

      param_name   = "#{fieldable_type.demodulize.underscore}_id"
      param_object = fieldable_type.constantize
      finder       = param_object.respond_to?(:friendly) ? param_object.friendly : param_object

      @object = finder.find(params[param_name])
    end

    # Permits metafield params from forms
    # @private
    def metafield_params
      params.require(:metafield).permit(:key, :value, :fieldable_id, :fieldable_type, :site_id)
    end
  end
end
