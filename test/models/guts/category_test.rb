require "test_helper"

module Guts
  class CategoryTest < ActiveSupport::TestCase
    test "should not create without title" do
      category = Category.new
      
      assert_not category.save
    end
    
    test "should not create with title less than three characters" do
      category       = Category.new
      category.title = "12" 
      
      assert_not category.save
    end
    
    test "should create slug for title" do
      category       = Category.new
      category.title = "Super Duper Category!" 
      category.save
      
      assert_equal "super-duper-category", category.slug
    end
    
    test "should return navigatable format" do
      assert_equal ":title", Category.navigatable_opts[:format]
      assert_equal [:title], Category.navigatable_opts[:variables]
      
      category = guts_categories :test_category
      assert_equal "Super Category!", category.navigatable_format
    end
    
    test "should return contents for category" do
      category = guts_categories :test_category
      
      assert_operator category.contents.size, :>, 0
    end
    
    test "should return metafields for category" do
      category = guts_categories :test_category
      
      assert_operator category.metafields.size, :>, 0
    end
    
    test "should be trackable" do
      assert_equal true, Category.methods.include?(:trackable)
    end
    
    test "category should be multisite compatible" do
      assert Category.all.to_sql.include?('site_id')
    end
  end
end
