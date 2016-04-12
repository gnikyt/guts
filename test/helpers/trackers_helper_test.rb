require 'test_helper'

module Guts
  class TrackersHelperTest < ActionView::TestCase
    test 'returns proper view name' do
      track = guts_trackers :one
      
      assert_equal 'guts/trackers/actions/content_update', track_view_for(track)
    end
  end
end
