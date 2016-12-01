require 'test_helper'

module Guts
  class ApplicationControllerWithMultisiteTest < ActionController::TestCase
    setup do
      @controller = Guts::IndexController.new
      @routes     = Engine.routes
    end

    test 'should set current site and current site should be nil' do
      get :index
      assert_nil assigns('current_site')
    end

    test 'should set current site with actual site' do
      @request.host = 'fr.testsite.com'
      get :index

      assert_instance_of Guts::Site, assigns('current_site')
      assert_equal @request.host, assigns('current_site').domain
    end
  end
end
