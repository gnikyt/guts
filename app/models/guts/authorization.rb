module Guts
  # Authorizations model
  class Authorization < ActiveRecord::Base
    has_many :permissions
  end
end
