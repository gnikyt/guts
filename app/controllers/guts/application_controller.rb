module Guts
  # Main inherited controller class
  # @abstract
  class ApplicationController < ActionController::Base
    include SessionConcern
    include MultisiteConcern
    include Pundit

    protect_from_forgery with: :exception
    before_action :current_user

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    # Gets the current user's record
    # @private
    # @note This is a `before_action` callback
    # @return [Object] the user object
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    # Sends the user to the login screen if not authorized
    # @note This is called when Pundit raises exception
    # @private
    def user_not_authorized
      flash[:alert] = 'You are not authorized.'
      redirect_to new_session_path
    end
  end
end
