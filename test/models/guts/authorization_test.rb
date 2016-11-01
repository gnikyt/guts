require 'test_helper'

module Guts
  class AuthorizationTest < ActiveSupport::TestCase
    test 'should create a authorization' do
      auth = Authorization.new(
        subject_class: 'Guts::Type',
        action: 'manage'
      )

      assert auth.save
    end

    test 'should create a authorization with subject_id' do
      auth = Authorization.new(
        subject_class: 'Guts::Type',
        action: 'manage',
        subject_id: 3
      )

      assert auth.save
    end

    test 'should not create authorization with validation issues' do
      # Missing class
      auth1 = Authorization.new(
        action: 'manage',
        subject_id: 3
      )

      # Missing action
      auth2 = Authorization.new(
        subject_class: 'Guts::Type',
        subject_id: 3
      )

      # Invalid subject_id
      auth3 = Authorization.new(
        subject_class: 'Guts::Type',
        action: 'manage',
        subject_id: 'whoops'
      )

      assert_equal false, auth1.save
      assert_equal false, auth2.save
      assert_equal false, auth3.save
    end

    test 'should format class and action' do
      auth = guts_authorizations :type_authorization

      assert_equal 'Guts::Type (manage) for ID: 3', auth.class_with_action
      assert_equal 'Type (Manage) For Id: 3', auth.class_with_action_cleaner
    end
  end
end
