module Guts
  # View helpers for users
  module UsersHelper
    # Gets the user's gravatar
    # @param [Object] user the user's object
    # @return [String] the image HTML
    # @note Sets a class of `gravatar` to the image HTML
    def gravatar_for(user)
      gravatar_id  = Digest::MD5.hexdigest user.email.downcase
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      
      image_tag gravatar_url, alt: user.name, class: 'gravatar'
    end
  end
end
