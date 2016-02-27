require "test_helper"

module Guts
  class TrackersControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:tracks)
    end
  end
end
