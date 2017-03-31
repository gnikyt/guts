require 'test_helper'

module Guts
  class IndexPolicyTest < PolicyTest
    test 'index method can be accessed by all who are logged in' do
      assert permit(guts_users(:admin_user), nil, :index)
      assert permit(guts_users(:regular_user), nil, :index)
      assert_not permit(nil, nil, :index)
    end
  end
end