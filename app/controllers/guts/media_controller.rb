require_dependency 'guts/application_controller'

module Guts
  # Media controller
  class MediaController < ApplicationController
    before_action :set_object
    before_action :set_medium, only: [:show, :edit, :update, :destroy, :editor_insert]
    before_action :set_per_page, only: [:index]

    # Displays a list of media
    # @note Depending on the object passed (polymorphic)
    def index
      @media = if @object
                 @object.media.paginate(page: params[:page], per_page: @per_page)
               else
                 Medium.paginate(page: params[:page], per_page: @per_page)
               end
    end

    # Shows details about a single medium
    def show
    end

    # Creation of a new medium
    def new
      @medium = Medium.new
    end

    # Editing for a medium
    def edit
    end

    # Creates a medium through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @medium = Medium.new medium_params

      if @medium.save
        flash[:notice] = 'Media was successfully created.'
        redirect_to edit_polymorphic_path([@object, @medium])
      else
        render :new
      end
    end

    # Updates a medium through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @medium.update(medium_params)
        flash[:notice] = 'Media was successfully updated.'
        redirect_to edit_polymorphic_path([@object, @medium])
      else
        render :edit
      end
    end

    # Destroys a medium
    # @note Redirects to #index on success
    def destroy
      @medium.destroy

      flash[:notice] = 'Media was successfully destroyed.'
      redirect_to polymorphic_path([@object, :media])
    end

    # Handles showing the insert medium
    # allowing TinyMce to use it
    def editor_insert
      render :editor_insert, layout: false
    end

    private

    # Sets a medium from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_medium
      @medium = Medium.find params[:id]
    end

    # Determines the polymorphic object if available
    # @private
    def set_object
      filable_type = params[:filable_type]

      return nil if filable_type.nil?

      param_name   = "#{filable_type.demodulize.underscore}_id"
      param_object = filable_type.constantize

      @object = param_object.find(params[param_name])
    end

    # Permits medium params from forms
    # @private
    def medium_params
      params.require(:medium).permit(
        :title,
        :tags,
        :position,
        :caption,
        :file,
        :filable_type,
        :filable_id,
        :site_id
      )
    end

    # Gets the per-page value to use
    # @note Default is 30
    # @private
    def set_per_page
      @per_page = params[:per_page] || 30
    end
  end
end
