require_dependency 'guts/application_controller'

module Guts
  # Index controller
  class IndexController < ApplicationController
    # Displays the welcome page
    def index
      authorize [:guts, :index], :index?
    end
  end
end
