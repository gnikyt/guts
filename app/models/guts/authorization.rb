module Guts
  # Authorizations model
  class Authorization < ActiveRecord::Base
    has_many :permissions

    # Shows a class with an action
    # @returns [String] compiled string with class, action, and ID (if present)
    def class_with_action
      string = "#{self[:subject_class]} (#{self[:action]})"
      string << " for ID: #{self[:subject_id]}" if self[:subject_id]

      string
    end

    # Shows a cleaner class with an action
    # @returns [String] compiled string with class, action, and ID (if present)
    def class_with_action_cleaner
      class_with_action.gsub(/Guts::/, '').titleize
    end
  end
end
