module Guts
  # Content model
  class Content < ActiveRecord::Base
    extend FriendlyId
    include NavigatableConcern
    include TrackableConcern
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

    friendly_id :title, use: [:slugged, :finders]
    navigatable :'type.title', :title, format: '[:type.title] :title'
    trackable :create, :update, :destroy, fields: [:title, :visible, :tags, :slug]
  end
end
