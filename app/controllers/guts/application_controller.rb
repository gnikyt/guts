module Guts
  # Main inherited controller class
  # @abstract
  class ApplicationController < ActionController::Base
    include SessionConcern
    include MultisiteConcern

    protect_from_forgery with: :exception
    before_action :current_user

    # Handles when user is not authorized from CanCanCan
    rescue_from CanCan::AccessDenied do |exception|
      # Redirects to login screen with error message
      redirect_to new_session_path, alert: exception.message
    end

    # Used by CanCanCan for getting the current abilities of the current user
    # @return [Class] the abilities for the current user
    def current_ability
      @current_ability ||= Guts::Ability.new current_user
    end

    protected

    # Gets the current user's record
    # @return [Object] the user object
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
