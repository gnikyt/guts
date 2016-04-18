module Guts
  # Tracker model
  class Tracker < ActiveRecord::Base
    include MultisiteScopeConcern
    
    belongs_to :site
    belongs_to :object, polymorphic: true
    serialize :params, JSON
    
    default_scope { order(created_at: :desc) }
  end
end
