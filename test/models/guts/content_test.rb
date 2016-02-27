require "test_helper"

module Guts
  class ContentTest < ActiveSupport::TestCase
    test "should not create without title" do
      content = Content.new
      
      assert_not content.save
    end
    
    test "should not create without type" do
      content      = Content.new
      content.type = guts_types :page_type
      
      assert_not content.save
    end
    
    test "should not create with title less than three characters" do
      content       = Content.new
      content.title = "12" 
      
      assert_not content.save
    end
    
    test "should create slug for title" do
      content       = Content.new
      content.title = "How to win an XBOX"
      content.save
      
      assert_equal "how-to-win-an-xbox", content.slug
    end
    
    test "should return navigatable format" do
      assert_equal "[:type.title] :title", Content.navigatable_opts[:format]
      assert_equal [:"type.title", :title], Content.navigatable_opts[:variables]
      
      content = guts_contents :test_page
      assert_equal "[Page] Test Page", content.navigatable_format
    end

    test "should return category for content" do
      content  = guts_contents :test_page
      category = guts_categories :test_category
      
      assert_includes content.categories, category
    end
    
    test "should return metafields for content" do
      content = guts_contents :test_page
      
      assert_operator content.metafields.size, :>, 0
    end
    
    test "should be trackable" do
      assert_equal true, Content.methods.include?(:trackable)
    end
    
    test "should return user" do
      content = guts_contents :test_page
      assert_not_nil content.user
    end
    
    test "should return no user" do
      content = guts_contents :test_page_2
      assert_nil content.user
    end
  end
end
