module Guts
  class Permission < ActiveRecord::Base
    has_many :assignments
    has_many :users, through: :assignments
  end
end
