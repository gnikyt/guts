require 'test_helper'

module Guts
  class ApplicationHelperTest < ActionView::TestCase
    # Mock type_path
    def type_path(_)
      '/guts/types'
    end
    
    # Mocking params
    def params
      { controller: 'guts/types', action: 'edit' }
    end
    
    test 'should return a destroy link' do
      link = link_to_destroy 'Remove User', '/users', class: 'user_link'
      html = Nokogiri::HTML link
      
      assert_equal 'destroy_resource user_link', html.xpath('//a').attr('class').value
      assert_equal '#', html.xpath('//a').attr('href').value
      assert_equal 'display: none', html.xpath('//form').attr('style').value
      assert html.xpath('//form').attr('method').value.downcase.include?('post')
      assert html.css('form input[name="_method"]').attr('value').value.downcase.include?('delete')
      assert_equal '/users', html.xpath('//form').attr('action').value
    end
    
    test 'should return subtitle format' do
      assert_equal 'Navigation Item', sub_title_for(guts_navigation_items(:test_navigation_item))
    end
    
    test 'should return proper css ID' do
      assert_equal 'guts_types_edit', controller_css_id
    end
    
    test 'should return menu as active' do
      assert_equal true, menu_active?(:test)
    end
    
    test 'should return menu as active non-strict' do
      assert_equal true, menu_active?(:test, false)
    end
    
    test 'should not return menu as active' do
      assert_equal false, menu_active?(:types)
    end
    
    test 'should return hidden form field for site ID' do
      form_html = capture do
        form_for guts_types(:page_type) do |f|
          current_site_form_field f
        end
      end

      assert form_html.include?('type[site_id]')
    end
  end
end
