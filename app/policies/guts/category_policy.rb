module Guts
  # Categories policy
  class CategoryPolicy < ApplicationPolicy
    # Policy for index method
    # @return [Boolean] allowed or denied
    def index?
      is_admin? || user_grant?(:guts_category, :index) || groups_grant?(:guts_category, :index)
    end
  end
end
