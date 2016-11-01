module Guts
  # Group model
  class Group < ActiveRecord::Base
    extend FriendlyId
    include TrackableConcern

    validates :title, presence: true, length: { minimum: 3 }

    has_many :user_groups
    has_many :users, through: :user_groups
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    has_many :tracks, as: :object
    has_many :permissions, as: :permissionable, dependent: :destroy

    friendly_id :title, use: [:slugged, :finders]
    trackable :create, :update, :destroy, fields: [:title]

    # Updates slug if title changes
    # @return [Boolean]
    def should_generate_new_friendly_id?
      title_changed?
    end
  end
end
