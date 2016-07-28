module Guts
  # Extension registry for Guts
  module ExtensionRegistry
    # List of all registered extensions
    # @return [Array]
    def self.extensions
      @extensions ||= []
    end

    # Registers a new extension to Guts via a block
    def self.register
      # Create new extension
      extension = Extension.new

      # Pass so block can configure
      yield extension

      # Register it
      extensions << extension
    end

    # Singular extension configuration
    class Extension
      # Name of the extension
      attr_accessor :name, :menus
    end
  end
end
