require_dependency 'guts/application_controller'

module Guts
  # Contents controller
  class ContentsController < ApplicationController
    include ControllerPermissionConcern
    
    before_action :set_content, only: [:show, :edit, :update, :destroy]
    before_action :set_type
    before_action :set_per_page, only: [:index]

    # Displays a list of contents
    # @note This method must have a type set
    def index
      @contents = Content.where(type: @type).paginate(page: params[:page], per_page: @per_page)
    end

    # Creation of a content
    def new
      @content = Content.new
    end

    # Shows details about a single content
    def show
    end

    # Editting of a content
    def edit
    end

    # Creates a content through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @content      = Content.new content_params
      @content.user = current_user
      @content.type = @type

      if @content.save
        flash[:notice] = "#{@content.type.title} was successfully created."
        redirect_to edit_content_path(@content)
      else
        render :new
      end
    end

    # Updates a content through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @content.update(content_params)
        flash[:notice] = "#{@content.type.title} was successfully updated."
        redirect_to edit_content_path(@content)
      else
        render :edit
      end
    end

    # Destroys a content
    # @note Redirects to #index on success
    def destroy
      @content.destroy

      flash[:notice] = "#{@content.type.title} was successfully destroyed."
      redirect_to contents_path(type: @content.type.slug)
    end

    private

    # Sets a content from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_content
      @content = Content.find params[:id]
    end

    # Sets the type from either params or current content object
    # @note This is a `before_action` callback
    # @private
    def set_type
      @type = if @content && !@content.new_record?
                @content.type
              else
                Type.find params[:type]
              end
    end

    # Permits content params from forms
    # @private
    def content_params
      params.require(:content).permit(
        :title,
        :slug,
        :content,
        :visible,
        :tags,
        :site_id,
        category_ids: []
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
