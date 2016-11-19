require 'test_helper'

module Guts
  class ContentsControllerTest < ActionController::TestCase
    setup do
      @content = guts_contents :test_page
      @type    = guts_types :page_type
      @routes  = Engine.routes
    end

    test 'should get index with type' do
      get :index, params: { type: @type.slug }
      assert_response :success
      assert_not_nil assigns(:contents)
    end

    test 'should get new' do
      get :new, params: { type: @type.slug }
      assert_response :success
    end

    test 'should create content' do
      assert_difference('Content.count') do
        post :create, params: {
          type: @type.slug,
          content: {
            slug: 'demo-page',
            title: 'Demo Page',
            visible: true,
            contents: 'Content',
            type_id: @type.id
          }
        }
      end

      assert_redirected_to edit_content_path(assigns(:content))
      assert flash[:notice].include?('successfully created')
    end

    test 'should fail to create content item and send back to new' do
      post :create, params: {
        type: @type.slug,
        content: { title: '' }
      }

      assert_template 'guts/contents/new'
    end

    test 'should show content' do
      get :show, params: { id: @content }
      assert_response :success
    end

    test 'should get edit' do
      get :edit, params: { id: @content }
      assert_response :success
    end

    test 'should update content' do
      patch :update, params: {
        id: @content,
        content: {
          slug: @content.slug,
          title: @content.title
        }
      }

      assert_redirected_to edit_content_path(assigns(:content))
      assert flash[:notice].include?('successfully updated')
    end

    test 'should fail to edit content item and send back to edit' do
      patch :update, params: {
        id: @content,
        content: { title: '' }
      }

      assert_template 'guts/contents/edit'
    end

    test 'should destroy content' do
      assert_difference('Content.count', -1) do
        delete :destroy, params: { id: @content }
      end

      assert_redirected_to contents_path(type: @content.type.slug)
      assert flash[:notice].include?('successfully destroyed')
    end

    test 'should allow for custom paginated limit' do
      get :index, params: {
        per_page: 100,
        type: @type
      }

      assert_equal 100, assigns(:per_page).to_i
    end
  end
end
