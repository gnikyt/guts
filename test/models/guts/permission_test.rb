require 'test_helper'

module Guts
  class PermissionTest < ActiveSupport::TestCase
    test 'should add permission to user and group' do
      [guts_users(:admin_user), guts_groups(:test_group)].each do |obj|
        permission = Permission.new(
          permissionable: obj,
          authorization: guts_authorizations(:type_authorization)
        )

        assert permission.save
      end
    end

    test 'should not add if missing permissionable' do
      permission = Permission.new(
        authorization: guts_authorizations(:type_authorization)
      )

      assert_not permission.save
    end

    test 'should not add if missing authorization' do
      permission = Permission.new(
        permissionable: guts_users(:admin_user)
      )

      assert_not permission.save
    end
  end
end
