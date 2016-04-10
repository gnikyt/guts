require_dependency "guts/application_controller"

module Guts
  class SitesController < ApplicationController
    before_action :set_site, only: [:show, :set_default, :remove_default, :edit, :update, :destroy]

    def index
      @sites = Site.all
    end

    def show
    end
    
    def new
      @site = Site.new
    end

    def edit
    end

    def create
      @site = Site.new site_params

      if @site.save
        redirect_to sites_url, notice: 'Site was successfully created.'
      else
        render :new
      end
    end

    def update
      if @site.update site_params
        redirect_to sites_url, notice: 'Site was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @site.destroy
      redirect_to sites_url, notice: 'Site was successfully destroyed.'
    end
    
    def set_default
      old_default = Site.find_by(default: true)
      if old_default
        old_default.update_attribute(:default, false)
      end
      
      @site.update_attribute(:default, true)
      redirect_to sites_url, notice: 'Site was successfully set to default.'
    end
    
    def remove_default
      @site.update_attribute(:default, false)
      redirect_to sites_url, notice: 'Site was successfully changed to not default.'
    end

    private
      def set_site
        @site = Site.find params[:id]
      end

      def site_params
        params.require(:site).permit(:name, :domain)
      end
  end
end
