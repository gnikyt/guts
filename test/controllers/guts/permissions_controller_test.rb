require 'test_helper'

module Guts
  class PermissionsControllerTest < ActionController::TestCase
    include ActionDispatch::Routing::UrlFor

    setup do
      @user   = guts_users :admin_user
      @group  = guts_groups :test_group
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
      assert_not_nil assigns(:authorizations)
      assert_not_nil assigns(:grouped_auths)
    end

    test 'should create permission' do
      assert_difference('Permission.count') do
        post :create, params: {
          user_id: @user.id,
          permissionable_type: 'Guts::User',
          permission: {
            permissionable_type: 'Guts::User',
            permissionable_id: @user.id
          },
          authorization_ids: [guts_authorizations(:type_authorization).id]
        }
      end

      assert_redirected_to polymorphic_path([@user, :permissions])
      assert_equal 'Permission was successfully granted.', flash[:notice]
    end

    test 'should not create permission' do
      post :create, params: {
        user_id: @user.id,
        permissionable_type: 'Guts::User',
        permission: { a_girl_knows: nil },
        authorization_ids: [guts_authorizations(:type_authorization).id]
      }

      assert_template 'guts/permissions/new'
    end

    test 'should revoke permission' do
      assert_difference('Permission.count', -1) do
        delete :destroy, params: {
          id: @user.permissions.last,
          user_id: @user.id,
          permissionable_type: 'Guts::User'
        }
      end

      assert_redirected_to polymorphic_path([@user, :permissions])
      assert_equal 'Permission was revoked.', flash[:notice]
    end

    test 'should not revoke permission if invalid' do
      assert_difference('Permission.count', 0) do
        delete :destroy, params: {
          id: guts_permissions(:group_permission).id,
          user_id: @user.id,
          permissionable_type: 'Guts::User'
        }
      end

      assert_redirected_to polymorphic_path([@user, :permissions])
      assert_equal 'Error revoking permission.', flash[:notice]
    end
  end
end
