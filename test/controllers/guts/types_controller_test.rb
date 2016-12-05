require 'test_helper'

module Guts
  class TypesControllerTest < ActionController::TestCase
    setup do
      @type   = guts_types :page_type
      @routes = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:types)
    end

    test 'should get new' do
      get :new
      assert_response :success
    end

    test 'should create type' do
      assert_difference('Type.count') do
        post :create, params: {
          type: {
            title: 'Controller Type'
          }
        }
      end

      assert_redirected_to edit_type_path(assigns(:type))
      assert_equal 'Type was successfully created.', flash[:notice]
    end

    test 'should fail to create type and send back to new' do
      post :create, params: { type: { title: '' } }
      assert_template 'guts/types/new'
    end

    test 'should show type' do
      get :show, params: { id: @type }
      assert_response :success
    end

    test 'should get edit' do
      get :edit, params: { id: @type }
      assert_response :success
    end

    test 'should update type' do
      patch :update, params: {
        id: @type,
        type: {
          slug: @type.slug,
          title: @type.title
        }
      }

      assert_redirected_to edit_type_path(assigns(:type))
      assert_equal 'Type was successfully updated.', flash[:notice]
    end

    test 'should fail to edit type and send back to edit' do
      patch :update, params: {
        id: @type,
        type: { title: '' }
      }

      assert_template 'guts/types/edit'
    end

    test 'should destroy type' do
      assert_difference('Type.count', -1) do
        delete :destroy, params: { id: @type }
      end

      assert_redirected_to types_path
      assert_equal 'Type was successfully destroyed.', flash[:notice]
    end
  end
end
