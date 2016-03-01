require "test_helper"

module Guts
  class ApplicationControllerTest < ActionController::TestCase
    setup do
      @controller = Guts::UsersController.new
      @routes     = Engine.routes
    end
    
    test "should look layout_hook file from Rails app" do
      get :index
      assert_equal true, @response.body.include?("See you in the after")
    end
  end
end
