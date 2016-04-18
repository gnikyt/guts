module Guts
  # Controller concern for multisite into application
  module MultisiteConcern
    extend ActiveSupport::Concern
    
    included do
      around_action :with_current_site
    end
    
    # Sets the current site based on the request host
    # @return [Object, nil] the current site if found or nil
    def current_site
      @current_site ||= Site.find_by(domain: request.host)
    end
    
    # Wraps all actions to set current site for multisite
    # @see Guts::MultisiteConcern#current_site
    # @note This is a `around_action` method
    def with_current_site
      # Get the current site and begin action
      Site.current_id = current_site.try(:id)

      yield
    ensure
      # Clean up the current site ID
      Site.current_id = nil
    end
  end
end
