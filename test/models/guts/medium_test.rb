require "test_helper"

module Guts
  class MediumTest < ActiveSupport::TestCase
    setup do
      @medium = guts_media :test_file
    end
    
    test "should be trackable" do
      assert_equal true, Medium.methods.include?(:trackable)
    end
      
    test "should not create without title" do
      medium = Medium.new
      assert_not medium.save
    end
    
    test "should not create title less than three" do
      medium       = Medium.new
      medium.title = "xy" 
      assert_not medium.save
    end
    
    test "should not process paperclip for non images" do
      medium = Medium.new
      
      assert_equal false, medium.sizing_only_images
    end
    
    test "should process paperclip for images" do      
      assert_nil @medium.sizing_only_images
    end
    
    test "should return urls for different sizes" do
      Guts.configuration.file_image_sizing.each do |size|
        assert_match /#{size}/, @medium.file.url(size)
      end
    end
    
    test "should return polymorphic object for medium" do
      assert_instance_of Guts::Content, @medium.filable
    end
    
    test "medium should be multisite compatible" do
      assert Medium.all.to_sql.include?('site_id')
    end
  end
end
