require_dependency 'guts/application_controller'

module Guts
  # Users controller
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    # Displays a list of users
    # @note Filterable by group by passing `group` param
    def index
      if params[:group]
        @group = policy_scope(Group).find params[:group]
        @users = policy_scope(User).in_group(@group)
      else
        @users = policy_scope(User).all
      end
    end

    # Show details about a single user
    def show
      authorize @user
    end

    # Creation of a new user
    def new
      @user = User.new
      authorize @user
    end

    # Editing of a user
    def edit
      authorize @user
    end

    # Creates a user through post
    # @note Redirects to #index if successfull or re-renders #new if not
    def create
      @user = User.new user_params
      authorize @user

      if @user.save
        flash[:notice] = 'User was successfully created. Don\'t forget to add permissions.'
        redirect_to edit_user_path(@user)
      else
        render :new
      end
    end

    # Updates a user through patch
    # @note Redirects to #index if successfull or re-renders #edit if not
    def update
      authorize @user

      if @user.update(user_params)
        flash[:notice] = 'User was successfully updated.'
        redirect_to edit_user_path(@user)
      else
        render :edit
      end
    end

    # Destroys a single user
    # @note Redirects to #index on success
    def destroy
      authorize @user
      @user.destroy

      flash[:notice] = 'User was successfully destroyed.'
      redirect_to users_url
    end

    # Allows switching of users by passing `user_id` in params
    # @see Guts::SessionsConcern#log_in
    def switch_user
      authorize User, :switch_user?

      if request.post?
        user = User.find(params[:user_id])
        log_in user
        flash.now[:notice] = "You are now logged in as #{user.name}."
      end

      @users = policy_scope(User).all
    end

    private

    # Sets a user from the database using `id` param
    # @note This is a `before_action` callback
    # @private
    def set_user
      @user = User.find params[:id]
    end

    # Permits user params from forms
    # @private
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        group_ids: []
      )
    end
  end
end
