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

    # Determines if a user has permission to a resource and type
    # @param [Symbol|String] resource the resource (controller) name
    # @param [Symbol|String] method the method for the resource
    # @return [Boolean] if user has access to resource and method
    def grants?(resource, method)
      grants = permissions.where(resource: resource.to_s).pluck(:grant)
      grants.include? method.to_s.delete('?')
    end
  end
end
