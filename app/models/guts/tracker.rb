module Guts
  # Tracker model
  class Tracker < ActiveRecord::Base
    belongs_to :object, polymorphic: true
    serialize :params, JSON
  end
end
