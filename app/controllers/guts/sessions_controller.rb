require_dependency 'guts/application_controller'

module Guts
  # Sessions controller
  class SessionsController < ApplicationController
    # Creation of a new session (login page)
    def new
    end

    # Checks the users session through post
    # @note It will redirect to Guts::UsersController if successful and
    #   it will redirect back to #new if not
    # @see Guts::SessionsHelper#log_in
    def create
      user = User.find_by(email: params[:session][:email].downcase)

      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to users_path
      else
        flash.now[:notice] = 'Invalid login credentials'
        render :new
      end
    end

    # Destroys a user session
    # @see Guts::SessionsHelper#log_out
    def destroy
      log_out
      flash[:notice] = 'You have been logged out'
      redirect_to new_session_path
    end

    # Forgot password page
    def forgot
    end

    # Sends the user a new token by email to reset their password
    def forgot_token
      user = User.find_by(email: params[:session][:email].downcase)
      if user
        password = Digest::SHA1.hexdigest("#{Time.current}#{rand(100)}")[0, 8]
        user.update_attribute(:password_token, password)
        UserMailer.password_reset(user).deliver_now

        flash[:notice] = 'Your reset link has been sent to your inbox.'
        redirect_to new_session_path
      else
        flash.now[:notice] = 'Invalid email address'
        render :forgot
      end
    end

    # Resets the user's password
    def reset_password
      new_password = Digest::SHA1.hexdigest("#{Time.current}#{rand(100)}")[0, 8]
      user         = User.find_by(password_token: params[:token])
      user.update(password_token: nil, password: new_password)

      flash[:notice] = "Your new password is now: #{new_password}. You may now login with it."
      redirect_to new_session_path
    end
  end
end
