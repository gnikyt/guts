module Guts
  # Base application policies for Pundit
  # @abstract
  class ApplicationPolicy
    attr_reader :user, :record

    # Initilization for a policy
    # @param [Object|nil] user the user's object
    # @param [Object|nil] record the record from the database
    def initialize(user, record)
      @user = user
      @record = record
    end

    # Index method policy
    # @return [Boolean] allowed or denied
    def index?
      false
    end

    # Show method policy
    # @return [Boolean] allowed or denied
    def show?
      scope.where(id: record.id).exists?
    end

    # Create method policy
    # @return [Boolean] allowed or denied
    def create?
      false
    end

    # New method policy
    # @return [Boolean] allowed or denied
    def new?
      create?
    end

    # Update method policy
    # @return [Boolean] allowed or denied
    def update?
      false
    end

    # Edit method policy
    # @return [Boolean] allowed or denied
    def edit?
      update?
    end

    # Destroy method policy
    # @return [Boolean] allowed or denied
    def destroy?
      false
    end

    # Scope for policy
    # @return [Object] policy scope
    def scope
      Pundit.policy_scope!(user, record.class)
    end

    # Scope class for policy
    class Scope
      attr_reader :user, :scope

      # Initilization for scope
      # @param [Object|nil] user the user's object
      # @param [Object|nil] scope the scope object
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      # Calls the scope
      # @return [Object] the scope
      def resolve
        scope
      end
    end

    private

    # Checks if a user is granted access to a resource and method
    # @param [Symbol] resource the resource (controller) to check
    # @param [Symbol] method the method for the resource
    # @return [Boolean] accepted or denied
    def user_grant?(resource, method)
      @user.grant? resource, method
    end

    # Checks if a user's groups are granted access to a resource and method
    # @param [Symbol] resource the resource (controller) to check
    # @param [Symbol] method the method for the resource
    # @return [Boolean] accepted or denied
    def groups_grant?(resource, method)
      @user.groups.any? do |group|
        group.grant? resource, method
      end
    end

    # Checks if user is in the admin's group
    # @return [Boolean]
    def is_admin?
      @user.groups.map(&:slug).include? :admins
    end
  end
end
