module Guts
  class Site < ActiveRecord::Base
    include TrackableConcern
    
    validates :name, presence: true
    validates :domain, presence: true
    
    has_many :types
    has_many :categories
    has_many :navigations
    has_many :navigation_items
    has_many :navigation_metafields
    has_many :metafields, as: :fieldable
    has_many :tracks, as: :object
    has_many :media, as: :filable
    has_many :options
    
    trackable :create, :update, :destroy, fields: [:name]
    
    def is_default?
      self[:default] == true
    end
  end
end
