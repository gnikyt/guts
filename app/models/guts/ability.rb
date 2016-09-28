module Guts
  # Ability class for CanCanCan
  class Ability
    include CanCan::Ability

    # Initializes the user's abilities
    # @param [Object|Nil] user the user object
    def initialize(user)
      user ||= Guts::User.new

      # Loop over group permissions first
      user.groups.each do |group|
        group.permissions.each do |permission|
          conditions = { id: permission.authorization.subject_id } unless permission.authorization.subject_id.nil?
          can(
            permission.authorization.action.to_sym,
            subject_class(permission.authorization.subject_class),
            conditions
          )
        end
      end

      # Next, loop over user permissions which can override group permissions
      user.permissions.each do |permission|
        conditions = { id: permission.authorization.subject_id } unless permission.authorization.subject_id.nil?
        can(
          permission.authorization.action.to_sym,
          subject_class(permission.authorization.subject_class),
          conditions
        )
      end
    end

    private

    # Converts authorization subject into a class or symbol
    # @param [String] klass the string to check
    # @return [Class|Symbol] the result of the check
    def subject_class(klass)
      if klass.include? 'Guts::'
        klass.constantize
      else
        klass.to_sym
      end
    end
  end
end
