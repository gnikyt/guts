module Guts
  # Handles sending user-related emails
  class UserMailer < ApplicationMailer
    # Sends a password reset email to the user
    # @param [Object] user the user object
    def password_reset(user)
      @user  = user
      @token = user.password_token
      
      mail to: @user.email, subject: 'Reset Password'
    end
  end
end
