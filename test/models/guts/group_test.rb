require 'test_helper'

module Guts
  class GroupTest < ActiveSupport::TestCase
    test 'should not create without title' do
      group = Group.new

      assert_not group.save
    end

    test 'should not create with title less than three characters' do
      group       = Group.new
      group.title = '12'

      assert_not group.save
    end

    test 'should create slug for title' do
      group       = Group.new
      group.title = 'Customer Group'
      group.save

      assert_equal 'customer-group', group.slug
    end

    test 'should return users for group' do
      group = guts_groups :admins

      assert_operator group.users.size, :>, 0
    end

    test 'should return metafields for group' do
      group = guts_groups :admins

      assert_operator group.metafields.size, :>, 0
    end

    test 'should determine grant resource string' do
      group   = guts_groups :admins
      result  = group.send :grant_resource_string, %i(guts navigation_item)
      result2 = group.send :grant_resource_string, %i(guts type)
      result3 = group.send :grant_resource_string, Guts::User
      result4 = group.send :grant_resource_string, group

      assert_equal 'Guts::NavigationItem', result
      assert_equal 'Guts::Type', result2
      assert_equal 'Guts::User', result3
      assert_equal 'Guts::Group', result4
    end

    test 'should check grants' do
      group = guts_groups :admins

      assert_equal false, group.granted?(:non_existant_resource, :non_existant_method)
      assert_equal true, group.granted?(%i(guts type), :destroy) # From fixture
    end
  end
end
