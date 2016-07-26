require 'test_helper'

module Guts
  class ContentTest < ActiveSupport::TestCase
    setup do
      @user = guts_users :admin_user
    end

    test 'should not create without title' do
      content = Content.new

      assert_not content.save
    end

    test 'should not create without type' do
      content      = Content.new
      content.type = guts_types :page_type

      assert_not content.save
    end

    test 'should not create with title less than three characters' do
      content       = Content.new
      content.title = '12'

      assert_not content.save
    end

    test 'should create slug for title' do
      content       = Content.new
      content.title = 'How to win an XBOX'
      content.save

      assert_equal 'how-to-win-an-xbox', content.slug
    end

    test 'should create content with user' do
      content       = Content.new
      content.title = 'I love users'
      content.user  = @user
      content.save

      assert_not_nil content.user
    end

    test 'should return navigatable format' do
      assert_equal '[:type.title] :title', Content.navigatable_opts[:format]
      assert_equal [:'type.title', :title], Content.navigatable_opts[:variables]

      content = guts_contents :test_page
      assert_equal '[Page] Test Page', content.navigatable_format
    end

    test 'should return category for content' do
      content  = guts_contents :test_page
      category = guts_categories :test_category

      assert_includes content.categories, category
    end

    test 'should return metafields for content' do
      content = guts_contents :test_page

      assert_operator content.metafields.size, :>, 0
    end

    test 'should be trackable' do
      assert_equal true, Content.methods.include?(:trackable)
    end

    test 'should return user' do
      content = guts_contents :test_page
      assert_not_nil content.user
    end

    test 'should return no user' do
      content = guts_contents :test_page_2
      assert_nil content.user
    end

    test 'content should be multisite compatible' do
      assert Content.all.to_sql.include?('site_id')
    end

    test 'content should create multisite scoped friendly_id' do
      content          = Content.new
      content.title    = 'Home'
      content.site     = guts_sites :default_site
      content.type     = guts_types :page_type
      content.save!

      content2         = Content.new
      content2.title   = 'Home'
      content2.site    = guts_sites :nondefault_site
      content2.type    = guts_types :page_type
      content2.save!

      content3         = Content.new
      content3.title   = 'Home'
      content3.site    = guts_sites :nondefault_site
      content3.type    = guts_types :page_type
      content3.save!

      assert_equal 'home', content.slug
      assert_equal 'home', content2.slug
      assert_not_equal 'home', content3.slug
    end
  end
end
