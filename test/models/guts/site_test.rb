require 'test_helper'

module Guts
  class SiteTest < ActiveSupport::TestCase
    test 'should not create without name or domain' do
      site = Site.new

      assert_not site.save
    end

    test 'should return metafields for site' do
      site = guts_sites :default_site

      assert_operator site.metafields.size, :>, 0
    end
  end
end
