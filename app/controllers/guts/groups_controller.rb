require_dependency 'guts/application_controller'

module Guts
  # Groups controller
  class GroupsController < ApplicationController
    include ControllerPermissionConcern

    before_action :set_group, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

    # Displays a list of groups
    def index
      @groups = Group.all
    end

    # Shows details about a single group
    def show
    end

    # Creation of a new group
    def new
      @group = Group.new
    end

    # Editing for a group
    def edit
    end

    # Creates a group through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @group = Group.new group_params

      if @group.save
        flash[:notice] = 'Group was successfully created.'
        redirect_to edit_group_path(@group)
      else
        render :new
      end
    end

    # Updates a group through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      if @group.update(group_params)
        flash[:notice] = 'Group was successfully updated.'
        redirect_to edit_group_path(@group)
      else
        render :edit
      end
    end

    # Destroys a group
    # @note Redirects to #index on success
    def destroy
      @group.destroy

      flash[:notice] = 'Group was successfully destroyed.'
      redirect_to groups_url
    end

    private

    # Sets a group from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_group
      @group = Group.find params[:id]
    end

    # Permits group params from forms
    # @private
    def group_params
      params.require(:group).permit(:title)
    end
  end
end
