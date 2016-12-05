require 'test_helper'

module Guts
  class TypeTest < ActiveSupport::TestCase
    test 'should not create without title' do
      type = Type.new

      assert_not type.save
    end

    test 'should not create with title less than three characters' do
      type       = Type.new
      type.title = '12'

      assert_not type.save
    end

    test 'should create slug for title' do
      type       = Type.new
      type.title = 'i am a type good sir'
      type.save

      assert_equal 'i-am-a-type-good-sir', type.slug
    end

    test 'should return navigatable format' do
      assert_equal ':title', Type.navigatable_opts[:format]
      assert_equal [:title], Type.navigatable_opts[:variables]

      type = guts_types :page_type
      assert_equal 'Page', type.navigatable_format
    end

    test 'should return contents for type' do
      type    = guts_types :page_type
      content = guts_contents :test_page

      assert_includes type.contents, content
    end

    test 'should return metafields for type' do
      type = guts_types :page_type

      assert_operator type.metafields.size, :>, 0
    end

    test 'type should be multisite compatible' do
      assert Type.all.to_sql.include?('site_id')
    end

    test 'should have site id as null in scope' do
      sql = Type.all.to_sql
      assert sql.include?('"site_id" IS NULL')
    end

    test 'should have site id as integer in scope' do
      site = guts_sites(:nondefault_site)
      Site.current_id = site.id
      sql = Type.all.to_sql
      Site.current_id = nil

      assert sql.include?(site.id.to_s)
    end
  end
end
