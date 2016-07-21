require 'test_helper'
require 'generators/guts/extension/extension_generator'

module Guts
  class ExtensionGeneratorTest < Rails::Generators::TestCase
    tests Guts::ExtensionGenerator
    destination Rails.root.join('tmp/generators/extension')
    setup :prepare_destination

    test 'generator runs without errors' do
      run_generator ['homebrew']

      # Confirm structure
      basepath = 'vendor/extensions/guts-homebrews'
      assert_file "#{basepath}/Gemfile"
      assert_file "#{basepath}/guts-homebrews.gemspec"
      assert_file "#{basepath}/Rakefile"
      assert_file "#{basepath}/README.md"
      assert_file "#{basepath}/app/controllers/guts/homebrews/homebrews_controller.rb"

      # Confirm contents of Gemspec
      assert_file "#{basepath}/guts-homebrews.gemspec", /guts-homebrew/
      assert_file "#{basepath}/guts-homebrews.gemspec", /guts\/homebrews\/version/
      assert_file "#{basepath}/guts-homebrews.gemspec", /Guts::Homebrews::VERSION/
      assert_file "#{basepath}/guts-homebrews.gemspec", /s.add_dependency 'guts', '~> #{Guts::VERSION}'/

      # Confirm contents of controller
      assert_file "#{basepath}/app/controllers/guts/homebrews/homebrews_controller.rb", /module Homebrews/
      assert_file "#{basepath}/app/controllers/guts/homebrews/homebrews_controller.rb", /class HomebrewsController/
    end
  end
end
