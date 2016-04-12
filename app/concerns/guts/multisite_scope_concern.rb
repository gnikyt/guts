module Guts
  # Handled adding a default scope to Active Record calls for multisites
  module MultisiteScopeConcern
    extend ActiveSupport::Concern
    
    included do
      # http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Default/ClassMethods.html
      default_scope do
        # Scope queries to the current site
        # See: Guts::ApplicationController#current_site for where current_id is set to model
        where(site_id: Guts::Site.current_id)
      end
    end
  end
end
