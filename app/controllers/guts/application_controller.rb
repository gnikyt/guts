module Guts
  # Main inherited controller class
  # @abstract
  class ApplicationController < ActionController::Base
    include SessionsHelper
    include MultisiteConcern
    
    protect_from_forgery with: :exception
    before_action :firewall
    
    private
    # Checks if a user is logged in and an admin
    # If they are not, they are redirected to login
    # @private
    # @note This is a `before_action` method
    def firewall
      # Only run if not on session pages
      unless params[:controller].include? "session"
        # Only run if logged in
        if logged_in?
          # Check between current user's group and approved groups from configuration
          intersect = current_user.groups.map(&:title) & Guts.configuration.admin_groups
          if Guts.configuration.admin_groups.size > 0 && intersect.size == 0
            # Logged in user, but not approved for admin panel
            redirect_to new_session_path
          end
        else
          # Not logged in, go to login page
          redirect_to new_session_path
        end
      end
    end
  end
end
