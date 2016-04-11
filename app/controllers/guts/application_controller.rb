module Guts
  # Main inherited controller class
  # @abstract
  class ApplicationController < ActionController::Base
    include SessionsHelper
    
    protect_from_forgery with: :exception
    before_action :firewall
    around_action :with_current_site
    
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
    
    # Sets the current site based on the request host
    # @return [Object, nil] the current site if found or nil
    def current_site
      @current_site = Site.find_by(domain: request.host)
    end
    
    # Wraps all actions to set current site for multisite
    # @see Guts::ApplicationController#current_site
    def with_current_site
      begin
        # Get the current site and begin action
        Site.current_id = current_site.try(:id)
        yield
      ensure
        # Clean up the current site ID
        Site.current_id = nil
      end
    end
  end
end
