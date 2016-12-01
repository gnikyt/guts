require 'test_helper'

module Guts
  class OptionTest < ActiveSupport::TestCase
    test 'should not create without key' do
      option = Option.new

      assert_not option.save
    end

    test 'should create option' do
      option       = Option.new
      option.key   = 'one_key'
      option.value = 'To rule them all'

      assert_equal true, option.save
    end

    test 'should normalize key name' do
      option       = Option.new
      option.key   = 'One key!'

      option_two     = Option.new
      option_two.key = 'one_key_two'

      assert_equal 'one_key', option.key
      assert_equal 'one_key_two', option_two.key
    end

    test 'should not create with key less than three characters' do
      option     = Option.new
      option.key = 'xy'

      assert_not option.save
    end

    test 'should find by key using helper method' do
      assert_instance_of Option, Option.for_key(:test_key)
    end

    test 'option should be multisite compatible' do
      assert Option.all.to_sql.include?('site_id')
    end
  end
end
