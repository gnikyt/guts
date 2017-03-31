module Guts
  # User policy
  class UserPolicy < ApplicationPolicy
    # Switch user method policy
    # @return [Boolean] allowed or denied
    def switch_user?
      standard_check :switch_user?
    end
  end
end
