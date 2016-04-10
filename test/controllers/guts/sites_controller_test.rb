require 'test_helper'

module Guts
  class SitesControllerTest < ActionController::TestCase
    setup do
      @site   = guts_sites(:default_site)
      @site2  = guts_sites(:nondefault_site)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:sites)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create site" do
      assert_difference('Site.count') do
        post :create, site: { domain: @site.domain, name: @site.name }
      end

      assert_redirected_to sites_path
      assert_equal "Site was successfully created.", flash[:notice]
    end

    test "should show site" do
      get :show, id: @site
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @site
      assert_response :success
    end

    test "should update site" do
      patch :update, id: @site, site: { domain: @site.domain, name: @site.name }
      assert_redirected_to sites_path
      assert_equal "Site was successfully updated.", flash[:notice]
    end

    test "should destroy site" do
      assert_difference('Site.count', -1) do
        delete :destroy, id: @site
      end

      assert_redirected_to sites_path
      assert_equal "Site was successfully destroyed.", flash[:notice]
    end
    
    test "should set default site" do
      get :set_default, id: @site2
      @site2.reload
      
      assert_equal true, @site2.is_default?
      assert_redirected_to sites_path
      assert_equal "Site was successfully set to default.", flash[:notice]
    end
    
    test "should remove default site" do
      get :remove_default, id: @site
      @site.reload
      
      assert_equal false, @site.is_default?
      assert_redirected_to sites_path
      assert_equal "Site was successfully changed to not default.", flash[:notice]
    end
  end
end
