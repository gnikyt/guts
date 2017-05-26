require 'test_helper'

module Guts
  class PermissionsControllerTest < ActionController::TestCase
    include ActionDispatch::Routing::UrlFor

    setup do
      @user   = guts_users :admin_user
      @routes = Engine.routes
    end

    test 'should get index' do
      get :index, params: {
        permissionable_type: 'Guts::User',
        user_id: @user.id
      }

      assert_response :success
      assert_not_nil assigns(:object)
    end

    test 'should get new' do
      get :new, params: {
        permissionable_type: 'Guts::User',
        user_id: @user.id
      }

      assert_response :success
      assert_not_nil assigns(:permission)
      assert_not_nil assigns(:policies)
    end

    test 'should create permissions' do
      assert_difference('Permission.count', 2) do
        post :create, params: {
          user_id: @user.id,
          permissionable_type: 'Guts::User',
          permission: {
            permissionable_type: 'Guts::User',
            permissionable_id: @user.id
          },
          grants: {
            type: ['index'],
            user: ['destroy']
          }
        }
      end

      # Rails 5.1 Error: assert_redirected_to polymorphic_path([@user, :permissions])
      assert_response :redirect
      assert_equal 'Permission was successfully granted.', flash[:notice]
    end

    test 'should not create permission' do
      post :create, params: {
        user_id: @user.id,
        permissionable_type: 'Guts::User',
        permission: {
          permissionable_type: 'Guts::User',
          permissionable_id: @user.id
        },
        grants: {
          type: [nil]
        }
      }

      # Rails 5.1 Error: assert_redirected_to new_polymorphic_path([@user, :permission])
      assert_response :redirect
    end

    test 'should revoke permission' do
      assert_difference('Permission.count', -1) do
        delete :destroy, params: {
          id: @user.permissions.last,
          user_id: @user.id,
          permissionable_type: 'Guts::User'
        }
      end

      # Rails 5.1 Error: assert_redirected_to polymorphic_path([@user, :permissions])
      assert_response :redirect
      assert_equal 'Permission was revoked.', flash[:notice]
    end

    test 'should not revoke permission if it does not belong to the object' do
      assert_difference('Permission.count', 0) do
        delete :destroy, params: {
          id: guts_permissions(:permission_two).id,
          user_id: @user.id,
          permissionable_type: 'Guts::User'
        }
      end

      # Rails 5.1 Error: assert_redirected_to polymorphic_path([@user, :permissions])
      assert_response :redirect
      assert_equal 'Error revoking permission.', flash[:notice]
    end
  end
end
