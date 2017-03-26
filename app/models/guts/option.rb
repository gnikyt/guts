module Guts
  # Option model
  class Option < ApplicationRecord
    include MultisiteScopeConcern

    # Regex for replacing key values with
    KEY_REGEX = /[^a-zA-Z0-9_ ]/i

    validates :key, presence: true, length: { minimum: 3 }

    belongs_to :site

    # Setter override for setting key
    # @param [String] key the option key
    # @return [String] cleaned/formatted key
    def key=(key)
      self[:key] = key.gsub(KEY_REGEX, '').gsub(/\s+/, '_').downcase.chomp
    end

    # Simple helper lookup for keys
    # @param [Symbol] key the option key to look up
    # @return [Object] the option record
    def self.for_key(key)
      find_by key: key
    end
  end
end
