module Guts
  # Navigation item model
  class NavigationItem < ApplicationRecord
    include MultisiteScopeConcern

    before_create :set_position

    validates :title, presence: true

    belongs_to :site
    belongs_to :navigation
    belongs_to :navigatable, polymorphic: true, required: false
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy

    default_scope { order(position: :asc) }

    # Determines if the navigation item has a custom link
    # @return [Boolean]
    def custom?
      self[:navigatable_type].nil? || self[:navigatable_type].empty?
    end

    private

    # Sets the position (ordering) for a navigation item before creation
    def set_position
      max_position = Navigation.find(self[:navigation_id]).navigation_items.maximum(:position) || -1

      self[:position] = max_position + 1
    end
  end
end
