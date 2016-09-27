module Guts
  class Assignment < ActiveRecord::Base
    belongs_to :user
    belongs_to :permission
  end
end
