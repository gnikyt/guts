module Guts
  # Navigation model
  class Navigation < ApplicationRecord
    extend FriendlyId
    include MultisiteScopeConcern

    validates :title, presence: true

    belongs_to :site
    has_many :navigation_items, dependent: :destroy
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy

    friendly_id :title, use: %i[slugged scoped finders], scope: :site_id

    # Updates slug if title changes
    # @return [Boolean]
    def should_generate_new_friendly_id?
      title_changed?
    end
  end
end
