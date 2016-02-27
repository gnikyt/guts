module Guts
  # Main inherited controller class
  # @abstract
  class ApplicationController < ActionController::Base
    include SessionsHelper
    
    protect_from_forgery with: :exception
    
    before_action :firewall
    
    private
    # Checks if a user is logged in and an admin
    # If they are not, they are redirected to login
    # @private
    # @note This is a `before_action` method
    def firewall
      unless params[:controller].include? "session"
        redirect_to new_session_path unless logged_in? and (Guts.configuration.admin_groups.size && (current_user.groups.map(&:title) & Guts.configuration.admin_groups).size > 0)
      end
    end
  end
end
