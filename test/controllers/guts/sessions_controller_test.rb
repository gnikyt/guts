require 'test_helper'

module Guts
  class SessionsControllerTest < ActionController::TestCase
    setup do
      @user   = guts_users :admin_user
      @routes = Engine.routes
    end

    test 'should get login' do
      get :new
      assert_response :success
    end
    
    test 'should show error for invalid user' do
      post :create, session: { email: 'durkadurka@gmail.com' }
      assert_response :success
      assert_equal 'Invalid login credentials', flash[:notice]
    end
    
    test 'should login the user' do
      post :create, session: { email: @user.email, password: 'dingo' }
      assert_redirected_to users_path
    end
    
    test 'should log the user out' do
      get :destroy
      assert_equal 'You have been logged out', flash[:notice]
      assert_redirected_to new_session_path
    end
    
    test 'should get forgot password page' do
      get :forgot
      assert_response :success
    end
    
    test 'should set a forgot password token' do
      post :forgot_token, session: { email: @user.email }
      assert_equal 'Your reset link has been sent to your inbox.', flash[:notice]
      assert_redirected_to new_session_path
    end
    
    test 'should not set a forgot password token for invalid user' do
      post :forgot_token, session: { email: 'durkadurka@gmail.com' }
      assert_equal 'Invalid email address', flash[:notice]
    end
    
    test 'should reset the users password' do
      get :reset_password, token: 123456
      assert flash[:notice].include?('new password is now')
      assert_redirected_to new_session_path
    end
  end
end
