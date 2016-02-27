module Guts
  # Metafield model
  class Metafield < ActiveRecord::Base
    belongs_to :fieldable, polymorphic: true, required: false
    validates :key, presence: true
  end
end
