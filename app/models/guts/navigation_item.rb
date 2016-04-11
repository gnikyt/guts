module Guts
  # Navigation item model
  class NavigationItem < ActiveRecord::Base
    include MultisiteScopeConcern
    
    validates :title, presence: true
    
    belongs_to :site
    belongs_to :navigation
    belongs_to :navigatable, polymorphic: true, required: false
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    
    # Determines if the navigation item has a custom link
    # @return [Boolean]
    def is_custom?
      self[:navigatable_type].nil? or self[:navigatable_type].empty?
    end
  end
end
