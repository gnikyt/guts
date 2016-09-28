module Guts
  # This concern allows the controllers and tests to
  # login and log out users
  module SessionConcern
    extend ActiveSupport::Concern

    included do
      protected

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
    end
  end
end
