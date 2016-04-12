require 'test_helper'

module Guts
  class TrackerTest < ActiveSupport::TestCase
    test 'should return a track object' do
      track = guts_trackers :one

      assert_instance_of Guts::Content, track.object
    end
    
    test 'should return a track params in JSON Hash' do
      track = guts_trackers :one

      assert_instance_of Hash, track.params
    end

    test 'should have a before and after value for param' do
      track = guts_trackers :one

      assert_equal 2, track.params['title'].size
    end
    
    test 'tracker should be multisite compatible' do
      assert Tracker.all.to_sql.include?('site_id')
    end
  end
end
