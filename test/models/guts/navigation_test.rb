require "test_helper"

module Guts
  class NavigationTest < ActiveSupport::TestCase
    test "should not create without title" do
      navigation = Navigation.new
      
      assert_not navigation.save
    end
    
    test "should create slug for title" do
      navigation       = Navigation.new
      navigation.title = "Footer Menu" 
      navigation.save
      
      assert_equal "footer-menu", navigation.slug
    end
    
    test "should return metafields for navigation" do
      navigation = guts_navigations :test_navigation
      
      assert_operator navigation.metafields.size, :>, 0
    end
    
    test "should return items for navigation" do
      navigation = guts_navigations :test_navigation
      
      assert_operator navigation.navigation_items.size, :>, 0
    end
    
    test "should be trackable" do
      assert_equal true, Navigation.methods.include?(:trackable)
    end
    
    test "navigation item should be multisite compatible" do
      assert NavigationItem.all.to_sql.include?('site_id')
    end
    
    test "navigation should be multisite compatible" do
      assert Navigation.all.to_sql.include?('site_id')
    end
  end
end
