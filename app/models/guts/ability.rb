module Guts
  # Ability class for CanCanCan
  class Ability
    include CanCan::Ability

    def initialize(user)
      user.permissions.each do |permission|
        subject_class = if permission.subject_class.include?('Guts::')
                          permission.subject_class.constantize
                        else
                          permission.subject_class.to_sym
                        end

        if permission.subject_id.nil?
          can permission.action.to_sym, subject_class
        else
          can permission.action.to_sym, subject_class, id: permission.subject_id
        end
      end
    end
  end
end
