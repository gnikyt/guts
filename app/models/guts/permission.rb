module Guts
  # Polymorphic permissions model
  class Permission < ApplicationRecord
    belongs_to :permissionable, polymorphic: true, required: true

    validates :resource, presence: true
    validates :grant, presence: true
    validates_uniqueness_of :permissionable_id, scope: %i(permissionable_type resource grant)
  end
end
