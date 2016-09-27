module Guts
  # Ability class for CanCanCan
  class Ability
    include CanCan::Ability

    def initialize(user)
      user.groups.each do |group|
        group.permissions.each do |permission|
          conditions = { id: permission.subject_id } unless permission.subject_id.nil?
          can permission.action.to_sym, subject_class(permission.subject_class), conditions
        end
      end

      user.permissions.each do |permission|
        conditions = { id: permission.subject_id } unless permission.subject_id.nil?
        can permission.action.to_sym, subject_class(permission.subject_class), conditions
      end
    end

    private

    def subject_class(klass)
      if klass.include? 'Guts::'
        klass.constantize
      else
        klass.to_sym
      end
    end
  end
end
