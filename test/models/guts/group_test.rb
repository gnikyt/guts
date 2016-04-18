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
      group = guts_groups :test_group
      
      assert_operator group.users.size, :>, 0
    end
    
    test 'should return metafields for group' do
      group = guts_groups :test_group
      
      assert_operator group.metafields.size, :>, 0
    end
    
    test 'should be trackable' do
      assert_equal true, Group.methods.include?(:trackable)
    end
  end
end
