require_dependency 'guts/application_controller'

module Guts
  # Navigations ontroller
  class NavigationsController < ApplicationController
    before_action :set_navigation, only: %i(show edit update destroy reorder)

    # Displays a list of navigations
    def index
      @navigations = policy_scope(Navigation).all
    end

    # Shows details about a single navigation
    def show
      authorize @navigation
    end

    # Creation of a new navigation
    def new
      @navigation = Navigation.new
      authorize @navigation
    end

    # Editing of a navigartion
    def edit
      authorize @navigation
    end

    # Creates a navigation through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @navigation = Navigation.new navigation_params
      authorize @navigation

      if @navigation.save
        flash[:notice] = 'Navigation was successfully created.'
        redirect_to navigations_path
      else
        render :new
      end
    end

    # Updates a navigation through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      authorize @navigation

      if @navigation.update(navigation_params)
        flash[:notice] = 'Navigation was successfully updated.'
        redirect_to navigations_path
      else
        render :edit
      end
    end

    # Destroys a single navigation
    # @note Redirects to #index on success
    def destroy
      authorize @navigation
      @navigation.destroy

      flash[:notice] = 'Navigation was successfully destroyed.'
      redirect_to navigations_path
    end

    # Updates sorting for a navigation
    # @note This is an AJAX call
    def reorder
      authorize @navigation, :update?
      
      ActiveRecord::Base.transaction do
        @navigation.navigation_items.each do |item|
          find = params[:order].permit!.select { |_, v| v == item.id.to_s }
          item.update_attribute(:position, find.keys.first.to_i)
        end
      end

      head :ok
    end

    private

    # Sets a navigation from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_navigation
      @navigation = Navigation.find params[:id]
    end

    # Permits navigation params from forms
    # @private
    def navigation_params
      params.require(:navigation).permit(:title, :site_id)
    end
  end
end
