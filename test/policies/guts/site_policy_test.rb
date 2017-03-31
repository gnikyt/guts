require 'test_helper'

module Guts
  class SitePolicyTest < PolicyTest
    test 'all methods' do
      %i(index new create update edit destroy).each do |method|
        assert policy_permit(guts_users(:admin_user), method)
        assert_not policy_permit(guts_users(:regular_user), method)
      end
    end
  end
end