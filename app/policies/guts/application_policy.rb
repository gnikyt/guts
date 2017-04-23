module Guts
  # Base application policies for Pundit
  # @abstract
  class ApplicationPolicy
    # @return [Object|nil] the user's object
    attr_reader :user
    
    # @return [Object|nil] the record from the database
    attr_reader :record

    # Initilization for a policy
    # @param [Object|nil] user the user's object
    # @param [Object|nil] record the record from the database
    # @raise [Pundit::NotAuthorizedError] if user is not logged in
    def initialize(user, record)
      raise Pundit::NotAuthorizedError unless user

      @user = user
      @record = record
    end

    # Index method policy
    # @return [Boolean] allowed or denied
    def index?
      standard_check :index
    end

    # Show method policy
    # @return [Boolean] allowed or denied
    def show?
      scope.where(id: record.id).exists?
    end

    # Create method policy
    # @return [Boolean] allowed or denied
    def create?
      standard_check :create
    end

    # New method policy
    # @return [Boolean] allowed or denied
    def new?
      create?
    end

    # Update method policy
    # @return [Boolean] allowed or denied
    def update?
      standard_check :update
    end

    # Edit method policy
    # @return [Boolean] allowed or denied
    def edit?
      update?
    end

    # Destroy method policy
    # @return [Boolean] allowed or denied
    def destroy?
      standard_check :destory
    end

    # Scope for policy
    # @return [Object] policy scope
    def scope
      Pundit.policy_scope!(user, record.class)
    end

    # Scope class for policy
    class Scope
      # @return [Object|nil] the user's object
      attr_reader :user

      # @param [Object|nil] scope the scope object
      attr_reader :scope

      # Initilization for scope
      # @param [Object|nil] user the user's object
      # @param [Object|nil] scope the scope object
      def initialize(user, scope)
        @user  = user
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
    # @private
    # @param [Symbol|Class|Array] resource the resource (controller) to check
    # @param [Symbol|String] method the method for the resource
    # @return [Boolean] accepted or denied
    def user_granted?(resource, method)
      @user.granted? resource, method
    end

    # Checks if a user's groups are granted access to a resource and method
    # @private
    # @param [Symbol|Class|Array] resource the resource (controller) to check
    # @param [Symbol|String] method the method for the resource
    # @return [Boolean] accepted or denied
    def groups_granted?(resource, method)
      @user.groups.any? do |group|
        group.granted? resource, method
      end
    end

    # Checks if user is in the admin's group
    # @private
    # @return [Boolean]
    def admin?
      @user.in_group? :admins
    end

    # DRY code for checking methods
    # @private
    # @param [Symbol|String] method the method to check
    # @return [Boolean]
    def standard_check(method)
      class_name = self.class.to_s.remove('Policy').constantize

      admin? || user_granted?(class_name, method) || groups_granted?(class_name, method)
    end
  end
end
