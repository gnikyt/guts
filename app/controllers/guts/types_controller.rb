require_dependency "guts/application_controller"

module Guts
  # Types controller
  class TypesController < ApplicationController
    before_action :set_type, only: [:show, :edit, :update, :destroy]

    # Display a list of types
    def index
      @types = Type.all
    end

    # Show details about a single type
    def show
    end

    # Creation of a type
    def new
      @type = Type.new
    end

    # Editing of a type
    def edit
    end

    # Creates a type through post
    # @note Redirects to #index if successfull or re-renders #new if not    
    def create
      @type = Type.new type_params

      if @type.save
        redirect_to types_path, notice: "Type was successfully created."
      else
        render :new
      end
    end

    # Updates a type through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @type.update type_params
        redirect_to types_path, notice: "Type was successfully updated."
      else
        render :edit
      end
    end

    # Destroys a single type
    # @note Redirects to #index on success
    def destroy
      @type.destroy
      redirect_to types_path, notice: "Type was successfully destroyed."
    end

    private
    # Sets a type from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_type
      @type = Type.find params[:id]
    end

    # Permits type params from forms
    # @private
    def type_params
      params.require(:type).permit(:title, :slug)
    end
  end
end
