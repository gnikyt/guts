require 'test_helper'

module Guts
  class CategoryPolicyTest < PolicyTest
    def test_new
      user = guts_users :admin_user
      assert permit(user, Category.new, :new)
    end
  end
end