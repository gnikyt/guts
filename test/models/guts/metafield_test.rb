require 'test_helper'

module Guts
  class MetafieldTest < ActiveSupport::TestCase
    test 'should not create without key' do
      metafield = Metafield.new
      
      assert_not metafield.save
    end
    
    test 'should belong to a fieldable type' do
      metafield = guts_metafields :metafield_for_content

      assert metafield.fieldable
    end
    
    test 'metafield should be multisite compatible' do
      assert Metafield.all.to_sql.include?('site_id')
    end
  end
end
