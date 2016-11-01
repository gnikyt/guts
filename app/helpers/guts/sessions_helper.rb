module Guts
  # Helpers for sessions
  # @attr [Object] current_user the current user's object record
  # @note This is also used by the controllers
  module SessionsHelper
    # Simple wrapper for grabbing the current user from the controller
    # instance variable
    # @return [Object] the current user object
    def current_user
      @current_user
    end

    # Determins if the user is logged in
    # @return [Boolean] true for logged in, false for not
    def logged_in?
      !current_user.nil?
    end
  end
end
