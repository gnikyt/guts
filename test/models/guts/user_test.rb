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
      group = guts_groups :test_group

      assert_includes user.groups, group
    end

    test 'should return metafields for user' do
      user = guts_users :admin_user

      assert_operator user.metafields.size, :>, 0
    end

    test 'should be trackable' do
      assert_equal true, User.methods.include?(:trackable)
    end

    test 'should have abilities' do
      user = guts_users :admin_user

      assert user.respond_to?(:can?)
      assert user.respond_to?(:cannot?)
      assert_instance_of Ability, user.ability
    end
  end
end
