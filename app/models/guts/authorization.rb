module Guts
  class Authorization < ActiveRecord::Base
    has_many :permissions
  end
end
