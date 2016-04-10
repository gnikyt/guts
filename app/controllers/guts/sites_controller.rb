require_dependency "guts/application_controller"

module Guts
  # Sites controller
  class SitesController < ApplicationController
    before_action :set_site, only: [:show, :set_default, :remove_default, :edit, :update, :destroy]

    # Displays a list of sites
    def index
      @sites = Site.all
    end

    # Shows detaisl about a single site
    def show
    end
    
    # Creation of a site
    def new
      @site = Site.new
    end

    # Editting of a site
    def edit
    end

    # Creates a site through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @site = Site.new site_params

      if @site.save
        redirect_to sites_url, notice: 'Site was successfully created.'
      else
        render :new
      end
    end

    # Updates a site through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @site.update site_params
        redirect_to sites_url, notice: 'Site was successfully updated.'
      else
        render :edit
      end
    end

    # Destroys a site
    # @note Redirects to #index on success
    def destroy
      @site.destroy
      redirect_to sites_url, notice: 'Site was successfully destroyed.'
    end
    
    # Sets a site as default
    def set_default
      old_default = Site.find_by(default: true)
      if old_default
        old_default.update_attribute(:default, false)
      end
      
      @site.update_attribute(:default, true)
      redirect_to sites_url, notice: 'Site was successfully set to default.'
    end
    
    # Removes a site as default
    def remove_default
      @site.update_attribute(:default, false)
      redirect_to sites_url, notice: 'Site was successfully changed to not default.'
    end

    private
    # Sets a site from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_site
      @site = Site.find params[:id]
    end

    # Permits site params from forms
    # @private
    def site_params
      params.require(:site).permit(:name, :domain)
    end
  end
end
