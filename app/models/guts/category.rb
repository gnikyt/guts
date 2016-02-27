module Guts
  # Category model
  class Category < ActiveRecord::Base
    extend FriendlyId
    include NavigatableConcern
    include TrackableConcern
    
    validates :title, presence: true, length: {minimum: 3}
    
    has_many :categorizations
    has_many :tracks, as: :object
    has_many :contents, through: :categorizations
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    
    friendly_id :title, use: [:slugged, :finders]
    navigatable :title, format: ":title"
    trackable :create, :update, :destroy, fields: [:title, :slug]
  end
end
