module Guts
  # Main inherited controller class
  # @abstract
  class ApplicationController < ActionController::Base
    include SessionsHelper
    include MultisiteConcern

    protect_from_forgery with: :exception
    before_action :firewall
    load_and_authorize_resource unless: :session_controller?

    def current_ability
      @current_ability ||= Guts::Ability.new current_user
    end

    private

    # Redirect user to new session if not logged in
    # @private
    # @note This is a `before_action` method
    def firewall
      unless session_controller? || logged_in?
        redirect_to new_session_path
      end
    end

    def session_controller?
      controller_name =~ /session/i
    end
  end
end
