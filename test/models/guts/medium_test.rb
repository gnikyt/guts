require 'test_helper'

module Guts
  class MediumTest < ActiveSupport::TestCase
    setup do
      @medium = guts_media :test_file
    end

    test 'should not process paperclip for non images' do
      medium = Medium.new

      assert_equal false, medium.sizing_only_images
    end

    test 'should process paperclip for images' do
      assert_nil @medium.sizing_only_images
    end

    test 'should return urls for different sizes' do
      Guts.configuration.file_image_sizing.each do |size|
        assert @medium.file.url(size).include?(size[0].to_s)
      end
    end

    test 'should return polymorphic object for medium' do
      assert_instance_of Guts::Content, @medium.filable
    end

    test 'medium should be multisite compatible' do
      assert Medium.all.to_sql.include?('site_id')
    end

    test 'should create title based on filename if title empty' do
      medium                = Medium.new
      medium.file_file_name = 'Joker.jpg'
      medium.save

      assert_equal medium.file_file_name, medium.title
    end
  end
end
