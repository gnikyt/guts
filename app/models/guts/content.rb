module Guts
  # Content model
  class Content < ApplicationRecord
    extend FriendlyId
    include NavigatableConcern
    include MultisiteScopeConcern

    validates :type, presence: true
    validates :title, presence: true, length: { minimum: 3 }

    belongs_to :site
    belongs_to :type
    belongs_to :user, required: false
    has_many :categorizations
    has_many :categories, through: :categorizations
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    has_many :tracks, as: :object

    friendly_id :title, use: [:slugged, :scoped, :finders], scope: :site_id
    navigatable :'type.title', :title, format: '[:type.title] :title'

    # Updates slug if title changes
    # @return [Boolean]
    def should_generate_new_friendly_id?
      title_changed?
    end
  end
end
