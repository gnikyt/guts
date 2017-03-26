module Guts
  # Polymorphic permissions model
  class Permission < ApplicationRecord
    belongs_to :permissionable, polymorphic: true, required: true
  end
end
