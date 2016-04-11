module Guts
  # Metafield model
  class Metafield < ActiveRecord::Base
    include MultisiteScopeConcern
    
    belongs_to :site
    belongs_to :fieldable, polymorphic: true, required: false
    validates :key, presence: true
  end
end
