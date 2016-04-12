require "test_helper"

module Guts
  class NavigationItemTest < ActiveSupport::TestCase
    test "should not create without title" do
      navigation = NavigationItem.new
      
      assert_not navigation.save
    end
    
    test "should return metafields for navigation" do
      navigation = guts_navigation_items :test_navigation_item
      
      assert_operator navigation.metafields.size, :>, 0
    end
    
    test "should return navigation" do
      navigation = guts_navigation_items :test_navigation_item
      
      assert navigation.navigation
    end
    
    test "should return navigatable" do
      navigation = guts_navigation_items :test_navigation_item
      
      assert navigation.navigatable
    end
    
    test "should not be custom" do
      navigation = guts_navigation_items :test_navigation_item
      
      assert_equal false, navigation.custom?
    end
    
    test "should be custom" do
      navigation = guts_navigation_items :test_navigation_item_two
      
      assert_equal true, navigation.custom?
    end
  end
end
