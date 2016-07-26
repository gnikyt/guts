module Guts
  # Navigation model
  class Navigation < ActiveRecord::Base
    extend FriendlyId
    include TrackableConcern
    include MultisiteScopeConcern

    validates :title, presence: true

    belongs_to :site
    has_many :tracks, as: :object
    has_many :navigation_items, dependent: :destroy
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy

    friendly_id :title, use: [:slugged, :scoped, :finders], scope: :site_id
    trackable :create, :update, :destroy, fields: [:title]
  end
end
