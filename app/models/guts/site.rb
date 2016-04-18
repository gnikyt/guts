module Guts
  # Site model
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
    
    # Checks if a site is default
    # @return [Boolean]
    def default?
      self[:default] == true
    end
    
    # Sets the current site ID
    # @param [Integer] id the ID to use
    # @note I simply can not see a better way at the moment to handle this with default_scope
    def self.current_id=(id)
      Thread.current[:site_id] = id
    end
    
    # Gets the current site ID
    # @return [Integer] the ID
    # @note I simply can not see a better way at the moment to handle this with default_scope
    def self.current_id
      Thread.current[:site_id]
    end
  end
end
