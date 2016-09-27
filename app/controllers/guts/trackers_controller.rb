require_dependency 'guts/application_controller'

module Guts
  # Trackers controller
  class TrackersController < ApplicationController
    include ControllerPermissionConcern
    
    # Displays a list of tracks/logs
    def index
      @tracks = Tracker.all
    end
  end
end
