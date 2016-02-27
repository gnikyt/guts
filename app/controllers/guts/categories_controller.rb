require_dependency "guts/application_controller"

module Guts
  # Categories controller
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    # Displays a list of categories
    def index
      @categories = Category.all
    end

    # Shows details about a single category
    def show
    end

    # Creation of a new category
    def new
      @category = Category.new
    end

    # Editing for a category
    def edit
    end

    # Creates a category through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @category = Category.new category_params

      if @category.save
        redirect_to categories_path, notice: "Category was successfully created."
      else
        render :new
      end
    end

    # Updates a category through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @category.update category_params
        redirect_to categories_path, notice: "Category was successfully updated."
      else
        render :edit
      end
    end

    # Destroys a category
    # @note Redirects to #index on success
    def destroy
      @category.destroy
      redirect_to categories_path, notice: "Category was successfully destroyed."
    end

    private
    # Sets a category from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_category
      @category = Category.find params[:id]
    end

    # Permits category params from forms
    # @private
    def category_params
      params.require(:category).permit(:title, :slug)
    end
  end
end
