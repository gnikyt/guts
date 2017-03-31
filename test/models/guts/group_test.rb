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

    test 'should check grants' do
      group = guts_groups :admins

      assert_equal false, group.granted?(:non_existant_resource, :non_existant_method)
      assert_equal true, group.granted?(%i(guts type), :destroy) # From fixture
    end
  end
end
