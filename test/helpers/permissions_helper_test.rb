require 'test_helper'

module Guts
  class PermissionsHelperTest < ActionView::TestCase
    test 'returns cleaned subject class' do
      assert_equal 'Navigation Item', clean_subject_class('Guts::NavigationItem')
    end
  end
end
