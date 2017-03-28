module Guts
  # Polymorphic permissions model
  class Permission < ApplicationRecord
    belongs_to :permissionable, polymorphic: true, required: true

    validates :resource, presence: true
    validates :grant, presence: true
  end
end
