module Guts
  # User model
  class User < ActiveRecord::Base
    include TrackableConcern
    
    # Regex to test email against for validation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name, presence: true, length: {maximum: 50}
    validates :email,
      presence: true,
      length: {maximum: 255},
      format: {with: VALID_EMAIL_REGEX},
      uniqueness: {case_sensitive: false}
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true
    
    has_secure_password
    has_many :media, as: :filable, dependent: :destroy
    has_many :metafields, as: :fieldable, dependent: :destroy
    has_many :user_groups
    has_many :groups, through: :user_groups
    has_many :tracks, as: :object
    has_many :contents
    
    trackable :create, :update, :destroy, fields: [:name, :group_id]
    
    # Setter override for email to downcase and strip email before database
    def email=(email)
      self[:email] = email.downcase.strip
    end
  end
end
