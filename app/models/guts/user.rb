module Guts
  # User model
  class User < ActiveRecord::Base
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
    has_many :tracks, as: :object
    has_many :contents
    has_many :permissions, as: :permissionable, dependent: :destroy

    delegate :can?, :cannot?, to: :ability

    scope :in_group, ->(group) { includes(:groups).where(guts_groups: { id: group.id }) }

    # Setter override for email to downcase and strip email before database
    # @param [String] email the email to set
    # @return [String] cleaned email string
    def email=(email)
      self[:email] = email.downcase.strip
    end

    # Gets the user's abilties
    # @see Guts::Ability
    # @return [Class] the abilities for this user
    def ability
      @ability ||= Guts::Ability.new self
    end
  end
end
