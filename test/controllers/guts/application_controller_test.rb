require 'test_helper'

module Guts
  class ApplicationControllerTest < ActionController::TestCase
    setup do
      @controller = Guts::IndexController.new
      @routes     = Engine.routes
    end

    test 'should look for layout_hook file from Rails app' do
      log_in guts_users(:admin_user)
      get :index
      assert_equal true, @response.body.include?('See you in the after')
    end

    test 'should redirect for non logged in user' do
      log_out
      get :index
      assert_redirected_to new_session_path
    end
  end
end
