require 'test_helper'
require 'generators/guts/initializer/initializer_generator'

module Guts
  class InitializerGeneratorTest < Rails::Generators::TestCase
    tests Guts::InitializerGenerator
    destination Rails.root.join('tmp/generators/initializer')
    setup :prepare_destination

    test 'generator runs without errors' do
      assert_nothing_raised do
        run_generator
      end
    end
  end
end
