module Guts
  # Base ActiveRecord class for guts
  # @abstract
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end