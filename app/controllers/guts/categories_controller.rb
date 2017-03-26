require_dependency 'guts/application_controller'

module Guts
  # Categories controller
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i(show edit update destroy)

    # Displays a list of categories
    def index
      @categories = policy_scope(Category)
    end

    # Shows details about a single category
    def show
      authorize @category
    end

    # Creation of a new category
    def new
      @category = Category.new
    end

    # Editing for a category
    def edit
      authorize @category
    end

    # Creates a category through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @category = Category.new category_params
      authorize @category

      if @category.save
        flash[:notice] = 'Category was successfully created.'
        redirect_to edit_category_path(@category)
      else
        render :new
      end
    end

    # Updates a category through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      authorize @category

      if @category.update category_params
        flash[:notice] = 'Category was successfully updated.'
        redirect_to edit_category_path(@category)
      else
        render :edit
      end
    end

    # Destroys a category
    # @note Redirects to #index on success
    def destroy
      authorize @category
      @category.destroy

      flash[:notice] = 'Category was successfully destroyed.'
      redirect_to categories_path
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
      params.require(:category).permit(:title)
    end
  end
end
