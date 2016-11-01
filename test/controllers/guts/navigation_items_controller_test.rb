require 'test_helper'

module Guts
  class NavigationItemsControllerTest < ActionController::TestCase
    setup do
      @navigation = guts_navigations :test_navigation
      @item       = guts_navigation_items :test_navigation_item
      @routes     = Engine.routes
    end

    test 'should get index' do
      get :index, navigation_id: @navigation
      assert_response :success
      assert_not_nil assigns(:navigation_items)
      assert_template 'index'
    end

    test 'should get new' do
      get :new, navigation_id: @navigation
      assert_response :success
    end

    test 'should create navigation item' do
      assert_difference('NavigationItem.count') do
        post :create,
             navigation_id: @navigation,
             navigation_item: {
               title: 'Nav Item Test',
               custom: 'http://YesIAm.com/',
               navigatable_id: nil,
               navigatable_type: nil,
               navigation_id: @navigation.id
             }
      end

      assert_redirected_to navigation_navigation_items_path(@item.navigation)
      assert_equal 'Navigation item was successfully created.', flash[:notice]
    end

    test 'should fail to create navigation item and send back to new' do
      post :create, navigation_id: @navigation, navigation_item: { title: '' }
      assert_template 'guts/navigation_items/new'
    end

    test 'should show navigation' do
      get :show, navigation_id: @navigation, id: @item
      assert_response :success
    end

    test 'should get edit' do
      get :edit, navigation_id: @navigation, id: @item
      assert_response :success
    end

    test 'should update navigation item' do
      patch :update, navigation_id: @navigation, id: @item, navigation_item: { title: @item.title }
      assert_redirected_to navigation_navigation_items_path(@item.navigation)
      assert_equal 'Navigation item was successfully updated.', flash[:notice]
    end

    test 'should fail to update navigation item and send back to edit' do
      patch :update, id: @item, navigation_item: { title: '' }
      assert_template 'guts/navigation_items/edit'
    end

    test 'should destroy navigation item' do
      assert_difference('NavigationItem.count', -1) do
        delete :destroy, navigation_id: @navigation, id: @item
      end

      assert_redirected_to navigation_navigation_items_path(@navigation)
      assert_equal 'Navigation item was successfully destroyed.', flash[:notice]
    end

    test 'should get navigatable objects' do
      get :navigatable_objects, model: 'Guts::Content'

      assert_response :success
      assert_equal 'application/json; charset=utf-8', response.headers['Content-Type']
    end
  end
end
