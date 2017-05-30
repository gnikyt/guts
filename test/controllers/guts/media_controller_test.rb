require 'test_helper'

module Guts
  class MediaControllerTest < ActionController::TestCase
    include ActionDispatch::Routing::UrlFor

    setup do
      @medium     = guts_media :test_file
      @content    = guts_contents :test_page
      @user       = guts_users :admin_user
      @routes     = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:media)
    end

    test 'should get index for friendly' do
      get :index, params: {
        content_id: @content.id,
        filable_type: 'Guts::Content'
      }

      assert_response :success
      assert_not_nil assigns(:media)
    end

    test 'should get index for non friendly' do
      get :index, params: {
        user_id: @user.id,
        filable_type: 'Guts::User'
      }

      assert_response :success
      assert_not_nil assigns(:media)
    end

    test 'should get new and the basic uploader' do
      get :new, params: {
        content_id: @content.id,
        filable_type: 'Guts::Content'
      }

      assert_response :success
      assert_equal false, @response.body.include?('dropzone')
    end

    test 'should get new and the multi uploader' do
      get :new, params: {
        content_id: @content.id,
        filable_type: 'Guts::Content',
        multi: true
      }

      assert_response :success
      assert @response.body.include?('dropzone')
    end

    test 'should create medium basic' do
      assert_difference('Medium.count') do
        post :create, params: {
          content_id: @content.id,
          filable_type: 'Guts::Content',
          medium: {
            title: 'Demo File',
            file: fixture_file_upload('/guts/files/spongebob.png', 'image/png')
          }
        }
      end

      # Rails Error: assert_redirected_to edit_polymorphic_path([@content, assigns(:medium)])
      assert_response :redirect
      assert flash[:notice].include?('successfully created')
    end

    test 'should create medium multi via json' do
      assert_difference('Medium.count') do  
        post(
          :create,
          params: {
            content_id: @content.id,
            filable_type: 'Guts::Content',
            medium: {
              title: 'Demo File',
              file: fixture_file_upload('/guts/files/spongebob.png', 'image/png')
            }
          },
          format: :json
        )
      end

      assert_response :created
    end

    test 'should not create medium for bad file' do
      post :create, params: {
        content_id: @content.id,
        filable_type: 'Guts::Content',
        medium: {
          title: 'Bad File',
          file: fixture_file_upload('/guts/files/spongebob.zip', 'application/zip')
        }
      }

      assert_template 'guts/media/new'
    end

    test 'should not create medium for bad file via json' do
      post(
        :create,
        params: {
          content_id: @content.id,
          filable_type: 'Guts::Content',
          medium: {
            title: 'Bad File',
            file: fixture_file_upload('/guts/files/spongebob.zip', 'application/zip')
          }
        },
        format: :json
      )

      assert_response :unprocessable_entity
    end

    test 'should show medium' do
      get :show, params: {
        id: @medium,
        content_id: @content.id,
        filable_type: 'Guts::Content'
      }

      assert_response :success
    end

    test 'should get edit' do
      get :edit, params: {
        id: @medium,
        content_id: @content.id,
        filable_type: 'Guts::Content'
      }

      assert_response :success
    end

    test 'should update medium' do
      patch :update, params: {
        id: @medium.id,
        content_id: @content.id,
        filable_type: 'Guts::Content',
        medium: { title: 'Demo Me' }
      }

      # Rails 5.1 Error: assert_redirected_to edit_polymorphic_path([@content, assigns(:medium)])
      assert_response :redirect
      assert flash[:notice].include?('successfully updated')
    end

    test 'should not update medium for bad file' do
      post :update, params: {
        id: @medium.id,
        content_id: @content.id,
        filable_type: 'Guts::Content',
        medium: {
          file: fixture_file_upload('/guts/files/spongebob.zip', 'application/zip')
        }
      }

      assert_template 'guts/media/edit'
    end

    test 'should destroy media' do
      assert_difference('Medium.count', -1) do
        delete :destroy, params: {
          id: @medium,
          content_id: @content.id,
          filable_type: 'Guts::Content'
        }
      end

      # Rails 5.1 Error: assert_redirected_to polymorphic_path([@content, :media])
      assert_response :redirect
      assert flash[:notice].include?('successfully destroyed')
    end

    test 'should get editor insert' do
      get :editor_insert, params: {
        id: @medium,
        content_id: @content.id,
        filable_type: 'Guts::Content'
      }

      assert_response :success
      assert_template 'guts/media/editor_insert'
      assert_template layout: false
    end

    test 'should allow for custom paginated limit' do
      get :index, params: { per_page: 100 }
      assert_equal 100, assigns(:per_page).to_i
    end
  end
end
