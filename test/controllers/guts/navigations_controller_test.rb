require 'test_helper'

module Guts
  class NavigationsControllerTest < ActionController::TestCase
    setup do
      @navigation = guts_navigations :test_navigation
      @routes     = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:navigations)
    end

    test 'should get new' do
      get :new
      assert_response :success
    end

    test 'should create navigation' do
      assert_difference('Navigation.count') do
        post :create, params: {
          navigation: { title: 'Nav Test' }
        }
      end

      assert_redirected_to navigations_path
      assert_equal 'Navigation was successfully created.', flash[:notice]
    end

    test 'should fail to create navigation and send back to new' do
      post :create, params: {
        navigation: { title: '' }
      }

      assert_template 'guts/navigations/new'
    end

    test 'should show navigation' do
      get :show, params: { id: @navigation }
      assert_response :success
    end

    test 'should get edit' do
      get :edit, params: { id: @navigation }
      assert_response :success
    end

    test 'should update navigation' do
      patch :update, params: {
        id: @navigation,
        navigation: { title: @navigation.title }
      }

      assert_redirected_to navigations_path
      assert_equal 'Navigation was successfully updated.', flash[:notice]
    end

    test 'should fail to update navigation and send back to edit' do
      patch :update, params: {
        id: @navigation,
        navigation: { title: '' }
      }

      assert_template 'guts/navigations/edit'
    end

    test 'should update positions' do
      get_positions = lambda do
        @navigation.navigation_items.map { |ni| { id: ni.id, position: ni.position } }
      end

      # Get current positions of items
      current_item_positions = get_positions.call

      # Swap positions
      post :reorder, params: {
        id: @navigation,
        order: {
          current_item_positions[1][:position].to_s => current_item_positions[0][:id].to_s,
          current_item_positions[0][:position].to_s => current_item_positions[1][:id].to_s
        }
      }
      @navigation.reload

      # Grab new positions of items
      new_item_positions = get_positions.call

      assert_equal current_item_positions.first[:id], new_item_positions.last[:id]
      assert_equal current_item_positions.last[:id], new_item_positions.first[:id]
      assert_response :success
    end

    test 'should destroy navigation' do
      assert_difference('Navigation.count', -1) do
        delete :destroy, params: { id: @navigation }
      end

      assert_redirected_to navigations_path
      assert_equal 'Navigation was successfully destroyed.', flash[:notice]
    end
  end
end
