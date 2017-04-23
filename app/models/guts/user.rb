module Guts
  # User model
  class User < ApplicationRecord
    include GrantedConcern
    
    # Regex to test email against for validation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :name, presence: true, length: { maximum: 50 }
    validates :email,
              presence: true,
              length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    has_secure_password
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    has_many :user_groups
    has_many :groups, through: :user_groups
    has_many :contents
    has_many :permissions, as: :permissionable, dependent: :destroy

    scope :in_group, ->(group) { includes(:groups).where(guts_groups: { id: group.id }) }

    alias_attribute :title, :name

    # Setter override for email to downcase and strip email before database
    # @param [String] email the email to set
    # @return [String] cleaned email string
    def email=(email)
      self[:email] = email.downcase.strip
    end

    # Quick method for finding if a user is part of a group
    # @param [String|Symbol|Fixnum] value the value to lookup against
    # @return [Boolean] user is a part of the group
    # @example `current_user.in_group?(3)` by ID
    # @example `current_user.in_group?(:managers)` by slug
    # @example `current_user.in_group?('Admins')` by title
    def in_group?(lookup)
      if lookup.is_a?(Symbol)
        groups.map(&:slug).include? lookup.to_s
      elsif lookup.is_a?(String)
        groups.map(&:title).include? lookup
      else
        groups.map(&:id).include? lookup
      end
    end
  end
end
