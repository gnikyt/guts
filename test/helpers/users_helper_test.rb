require 'test_helper'

module Guts
  class UsersHelperTest < ActionView::TestCase
    setup do
      @user = guts_users :admin_user

      stub_request(:get, %r{https:\/\/secure.gravatar.com\/avatar\/.*}).to_return(body: '')
    end

    test 'returns a gravatar image' do
      gravatar  = gravatar_for @user
      html      = Nokogiri::HTML(gravatar).xpath('//img')
      email_md5 = Digest::MD5.hexdigest(@user.email.downcase)

      assert_equal 'gravatar', html.attr('class').value
      assert_equal @user.name, html.attr('alt').value
      assert_equal "https://secure.gravatar.com/avatar/#{email_md5}", html.attr('src').value
    end

    test 'returns a gravatar image with size' do
      @user = guts_users :admin_user
      gravatar  = gravatar_for @user, 500
      html      = Nokogiri::HTML(gravatar).xpath('//img')
      email_md5 = Digest::MD5.hexdigest(@user.email.downcase)

      assert_equal "https://secure.gravatar.com/avatar/#{email_md5}?s=500", html.attr('src').value
    end
  end
end
