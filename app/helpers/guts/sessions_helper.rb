module Guts
  # Helpers for sessions
  # @attr [Object] current_user the current user's object record
  # @note This is also used by the controllers
  module SessionsHelper
    # Set the User's ID to the session
    # @param [Object] user the user's object record
    def log_in(user)
      session[:user_id] = user.id
    end
    
    # Logs the user out by deleting the session
    def log_out
      session.delete :user_id
      @current_user = nil
    end

    # Gets the current user's record
    # @return [Object] the user object
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    # Determins if the user is logged in
    # @return [Boolean] true for logged in, false for not
    def logged_in?
      false === current_user.nil?
    end
  end
end
