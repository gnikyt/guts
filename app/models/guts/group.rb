module Guts
  # Group model
  class Group < ApplicationRecord
    extend FriendlyId

    validates :title, presence: true, length: { minimum: 3 }

    has_many :user_groups
    has_many :users, through: :user_groups
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    has_many :permissions, as: :permissionable, dependent: :destroy

    friendly_id :title, use: %i(slugged finders)

    # Updates slug if title changes
    # @return [Boolean]
    def should_generate_new_friendly_id?
      title_changed?
    end

    # Determines if a group has permission to a resource and type
    # @param [Symbol] resource the resource (controller) name
    # @param [Symbol] method the method for the resource
    # @return [Boolean] if group has access to resource and method
    def grants?(resource, method)
      grants = self[:permissions].where(resource: resource).pluck(:grant)
      grants.include? method
    end
  end
end
