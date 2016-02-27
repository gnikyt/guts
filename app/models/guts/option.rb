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
    
    # Simple helper lookup for keys
    # @param [Symbol] key the option key to look up
    # @return [Object] the option record
    def self.for_key(key)
      self.find_by_key(key)
    end
  end
end
