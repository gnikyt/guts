module Guts
  # Type model
  class Type < ActiveRecord::Base
    extend FriendlyId
    include NavigatableConcern
    include TrackableConcern
    include MultisiteScopeConcern

    validates :title, presence: true, length: { minimum: 3 }

    has_many :contents
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    has_many :tracks, as: :object

    friendly_id :title, use: [:slugged, :scoped, :finders], scope: :site_id
    navigatable :title, format: ':title'
    trackable :create, :update, :destroy, fields: [:title]
  end
end
