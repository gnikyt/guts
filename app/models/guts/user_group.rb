module Guts
  # User Group model joins User model and Group model
  # @see Guts::User
  # @see Guts::Group
  class UserGroup < ActiveRecord::Base
    belongs_to :user
    belongs_to :group
    has_many :permissions, as: :permissionable, dependent: :destroy
  end
end
