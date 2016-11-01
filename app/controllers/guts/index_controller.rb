require_dependency 'guts/application_controller'

module Guts
  # Index controller
  class IndexController < ApplicationController
    # Tell CanCanCan we don't have a model
    authorize_resource class: false

    # Displays the welcome page
    def index
    end
  end
end
