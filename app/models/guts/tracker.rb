module Guts
  # Tracker model
  class Tracker < ActiveRecord::Base
    include MultisiteScopeConcern
    
    belongs_to :site
    belongs_to :object, polymorphic: true
    serialize :params, JSON
  end
end
