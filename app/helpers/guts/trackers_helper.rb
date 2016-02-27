module Guts
  # View helpers for trackers/logs
  module TrackersHelper
    # Renders a track's partial
    # @param [Object] track the track's object record
    # @param [String, nil] layout the layout to wrap the partial in
    # @see TrackerHelper#track_view_for
    def render_track(track, layout = nil)
      return unless track.is_a? Guts::Tracker

      render partial: track_view_for(track), layout: layout, locals: {track: track}
    end
    
    # Determines the partial template for a track object
    # @return [String] compiled track partial template path
    def track_view_for(track)
      "guts/trackers/actions/#{track.object_type.demodulize.downcase}_#{track.action}"
    end
  end
end
