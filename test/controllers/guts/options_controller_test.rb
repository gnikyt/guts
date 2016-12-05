require 'test_helper'

module Guts
  class OptionsControllerTest < ActionController::TestCase
    setup do
      @option = guts_options :option_one
      @routes = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:options)
    end

    test 'should get new' do
      get :new
      assert_response :success
    end

    test 'should create option' do
      assert_difference('Option.count') do
        post :create, params: {
          option: {
            key: 'Testing Key',
            value: '123'
          }
        }
      end

      assert_redirected_to edit_option_path(assigns(:option))
      assert_equal 'Option was successfully created.', flash[:notice]
    end

    test 'should fail to create option and send back to new' do
      post :create, params: { option: { key: '' } }
      assert_template 'guts/options/new'
    end

    test 'should show option' do
      get :show, params: { id: @option }
      assert_response :success
    end

    test 'should get edit' do
      get :edit, params: { id: @option }
      assert_response :success
    end

    test 'should update option' do
      patch :update, params: {
        id: @option,
        option: { value: 'Hey!' }
      }

      assert_redirected_to edit_option_path(assigns(:option))
      assert_equal 'Option was successfully updated.', flash[:notice]
    end

    test 'should fail to edit option and send back to edit' do
      patch :update, params: {
        id: @option,
        option: { key: '' }
      }

      assert_template 'guts/options/edit'
    end

    test 'should destroy option' do
      assert_difference('Option.count', -1) do
        delete :destroy, params: { id: @option }
      end

      assert_redirected_to options_path
      assert_equal 'Option was successfully destroyed.', flash[:notice]
    end

    test 'should allow for custom paginated limit' do
      get :index, params: { per_page: 100 }
      assert_equal 100, assigns(:per_page).to_i
    end
  end
end
