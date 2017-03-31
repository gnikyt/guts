module Guts
  # Metafield model
  class Metafield < ApplicationRecord
    include MultisiteScopeConcern

    belongs_to :site
    belongs_to :fieldable, polymorphic: true, required: false
    
    validates :key, presence: true
  end
end
