module Guts
  # Polymorphic permissions model
  class Permission < ActiveRecord::Base
    belongs_to :permissionable, polymorphic: true, required: true
  end
end
