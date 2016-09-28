require_dependency 'guts/application_controller'

module Guts
  # Trackers controller
  class TrackersController < ApplicationController
    include ControllerPermissionConcern

    load_and_authorize_resource
    
    # Displays a list of tracks/logs
    def index
      @tracks = Tracker.all
    end
  end
end
