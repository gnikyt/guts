module Guts
  # Handles tracking model changes through callbacks
  module TrackableConcern
    extend ActiveSupport::Concern
    
    # Class methods for this concern
    module ClassMethods
      # Tracks changes to a model
      # @param [Array] types an array of callbacks to watch from ActiveRecord
      # @param [Hash] opts options for the tracker
      # @option opts [Array] :fields list of fields to track changes on
      # @example Example for Category model
      #   # Will track create and update, as well as title changes
      #   trackable :create, :update, fields: [:title]
      # @note This uses `self.changes` from ActiveRecord to track fields
      def trackable(*types, **opts)
        # Loop over each type
        types.each do |type|
          # Start the callback on this modal
          send :"after_#{type}" do
            params = {}

            # Check if we're watching for a specific field
            if opts[:fields] && type == :update
              # They do... grab those changes and merge them into our params
              params = changes.select { |field| opts[:fields].include? field.to_sym }
            end
            
            # Finally, complete the track to the database if allowed
            Tracker.create(action: type, object: self, params: params)
          end
        end
      end
    end
  end
end
