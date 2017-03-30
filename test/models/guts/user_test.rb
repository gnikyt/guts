require 'test_helper'

module Guts
  class UserTest < ActiveSupport::TestCase
    test 'should not create user without name' do
      user = User.new

      assert_not user.save
    end

    test 'should not create user with large name' do
      user      = User.new
      user.name = (0...80).map { |t| t }.join

      assert_not user.save
    end

    test 'should not create user with bad email' do
      user       = User.new
      user.name  = 'Admin'
      user.email = 'dudeman'

      assert_not user.save
    end

    test 'should not create user with existing email' do
      user       = User.new
      user.name  = 'Admin'
      user.email = guts_users(:admin_user).email

      assert_not user.save
    end

    test 'should not create user with small password' do
      user                        = User.new
      user.name                   = 'Admin'
      user.email                  = 'test@domain2.com'
      user.password               = 'one'
      user.password_confirmation  = 'one'

      assert_not user.save
    end

    test 'should downcase user email' do
      user       = User.new
      user.email = 'TEST@domain.com'

      assert_equal 'test@domain.com', user.email
    end

    test 'should belong to a group' do
      user  = guts_users :admin_user
      group = guts_groups :admins

      assert_includes user.groups, group
    end

    test 'should return metafields for user' do
      user = guts_users :admin_user

      assert_operator user.metafields.size, :>, 0
    end

    test 'should determine grant resource string' do
      user    = guts_users :admin_user
      result  = user.send :grant_resource_string, %i(guts navigation_item)
      result2 = user.send :grant_resource_string, %i(guts type)
      result3 = user.send :grant_resource_string, Guts::User
      result4 = user.send :grant_resource_string, user
      result5 = user.send :grant_resource_string, Hash
      result6 = user.send :grant_resource_string, 'Boo'

      assert_equal 'Guts::NavigationItem', result
      assert_equal 'Guts::Type', result2
      assert_equal 'Guts::User', result3
      assert_equal 'Guts::User', result4
      assert_equal Hash, result5
      assert_equal String, result6
    end

    test 'should check grants' do
      user = guts_users :admin_user

      assert_equal false, user.granted?(:non_existant_resource, :non_existant_method)
      assert_equal true, user.granted?(%i(guts type), :index) # From fixture
    end
  end
end
