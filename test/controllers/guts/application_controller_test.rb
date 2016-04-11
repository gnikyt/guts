require "test_helper"

module Guts
  class ApplicationControllerTest < ActionController::TestCase
    setup do
      @controller = Guts::UsersController.new
      @routes     = Engine.routes
    end
    
    test "should look for layout_hook file from Rails app" do
      get :index
      assert_equal true, @response.body.include?("See you in the after")
    end
    
    test "should set current site and current site should be nil" do
      get :index
      assert_equal nil, assigns('current_site')
      assert_equal nil, Guts::Site.current_id
    end
    
    test "should set current site with actual site" do
      @request.host = 'fr.testsite.com'
      get :index
      assert_instance_of Guts::Site, assigns('current_site')
    end
    
    test "should redirect for logged in user not in admin groups" do
      log_in guts_users(:regular_user)
      get :index
      assert_redirected_to new_session_path
    end
    
    test "should redirect for non logged in user" do
      log_out
      get :index
      assert_redirected_to new_session_path
    end
  end
end
