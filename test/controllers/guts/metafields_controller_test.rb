require 'test_helper'

module Guts
  class MetafieldsControllerTest < ActionController::TestCase
    include ActionDispatch::Routing::UrlFor

    setup do
      @metafield = guts_metafields :metafield_for_content
      @content   = guts_contents :test_page
      @user      = guts_users :admin_user
      @routes    = Engine.routes
    end

    test 'should get index' do
      get :index, content_id: @content.id, fieldable_type: 'Guts::Content'
      assert_response :success
      assert_not_nil assigns(:metafields)
    end

    test 'should get index for non friendly' do
      get :index, user_id: @user.id, fieldable_type: 'Guts::User'
      assert_response :success
      assert_not_nil assigns(:metafields)
    end

    test 'should get new' do
      get :new, content_id: @content.id, fieldable_type: 'Guts::Content'
      assert_response :success
    end

    test 'should create metafield' do
      assert_difference('Metafield.count') do
        post :create,
             content_id: @content.id,
             fieldable_type: 'Guts::Content',
             metafield: {
               key: 'Test',
               value: 'Test'
             }
      end

      assert_redirected_to edit_polymorphic_path([@content, assigns(:metafield)])
      assert flash[:notice].include?('successfully created')
    end

    test 'should not create metafield and send back to new' do
      post :create,
           content_id: @content.id,
           fieldable_type: 'Guts::Content',
           metafield: {
             key: '',
             value: ''
           }

      assert_template 'guts/metafields/new'
    end


    test 'should show metafield' do
      get :show, id: @metafield, content_id: @content.id, fieldable_type: 'Guts::Content'
      assert_response :success
    end

    test 'should get edit' do
      get :edit, id: @metafield, content_id: @content.id, fieldable_type: 'Guts::Content'
      assert_response :success
    end

    test 'should update metafield' do
      patch :update,
            id: @metafield.id,
            content_id: @content.id,
            fieldable_type: 'Guts::Content',
            metafield: { key: 'Demo Me' }

      assert_redirected_to edit_polymorphic_path([@content, assigns(:metafield)])
      assert flash[:notice].include?('successfully updated')
    end

    test 'should fail to edit metafield and send back to edit' do
      patch :update,
            id: @metafield.id,
            content_id: @content.id,
            fieldable_type: 'Guts::Content',
            metafield: { key: '' }

      assert_template 'guts/metafields/edit'
    end

    test 'should destroy metafield' do
      assert_difference('Metafield.count', -1) do
        delete :destroy, id: @metafield, content_id: @content.id, fieldable_type: 'Guts::Content'
      end

      assert_redirected_to polymorphic_path([@content, :metafields])
      assert flash[:notice].include?('successfully destroyed')
    end
  end
end
