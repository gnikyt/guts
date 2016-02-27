module Guts
  # Option model
  class Option < ActiveRecord::Base
    include TrackableConcern
    
    # Regex for replacing key values with
    KEY_REGEX = /[^a-zA-Z0-9_ ]/i
    
    validates :key, presence: true, length: {minimum: 3}
    
    trackable :create, :update, :destroy, fields: [:value]
    
    # Setter override for setting key
    def key=(key)
      self[:key] = key.gsub(KEY_REGEX, "").gsub(/\s+/, "_").downcase.chomp
    end
    
    # Helper lookup for keys
    def self.for_key(key)
      self.find_by_key(key)
    end
  end
end
