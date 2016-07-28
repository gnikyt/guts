require 'test_helper'
require 'generators/guts/extension/extension_generator'

module Guts
  class ExtensionGeneratorTest < Rails::Generators::TestCase
    tests Guts::ExtensionGenerator
    destination Rails.root.join('tmp/generators/extension')
    setup :prepare_destination

    test 'generator runs without errors' do
      run_generator [
        'homebrew',
        '--license=GPL',
        '--authors=Tyler King',
        '--author_emails=tyler.n.king@outlook.com'
      ]

      # Confirm structure
      basepath = 'vendor/extensions/guts-homebrews'
      assert_file "#{basepath}/Gemfile"
      assert_file "#{basepath}/guts-homebrews.gemspec"
      assert_file "#{basepath}/Rakefile"
      assert_file "#{basepath}/README.md"
      assert_file "#{basepath}/app/assets/"
      assert_file "#{basepath}/app/controllers/guts/homebrews/homebrews_controller.rb"
      assert_file "#{basepath}/app/models/guts/homebrews/"
      assert_file "#{basepath}/app/helpers/guts/homebrews/"
      assert_file "#{basepath}/app/views/guts/homebrews/homebrews/index.html.erb"
      assert_file "#{basepath}/config/routes.rb"
      assert_file "#{basepath}/lib/homebrews.rb"
      assert_file "#{basepath}/lib/guts/homebrews/engine.rb"
      assert_file "#{basepath}/lib/guts/homebrews/version.rb"

      # Confirm contents of Gemspec
      assert_file "#{basepath}/guts-homebrews.gemspec", /guts-homebrew/
      assert_file "#{basepath}/guts-homebrews.gemspec", /guts\/homebrews\/version/
      assert_file "#{basepath}/guts-homebrews.gemspec", /Guts::Homebrews::VERSION/
      assert_file "#{basepath}/guts-homebrews.gemspec", /s.add_dependency 'guts', '~> #{Guts::VERSION}'/
      assert_file "#{basepath}/guts-homebrews.gemspec", /Tyler King/
      assert_file "#{basepath}/guts-homebrews.gemspec", /tyler.n.king@outlook.com/
      assert_file "#{basepath}/guts-homebrews.gemspec", /GPL/

      # Confirm contents of controller
      assert_file "#{basepath}/app/controllers/guts/homebrews/homebrews_controller.rb", /module Homebrews/
      assert_file "#{basepath}/app/controllers/guts/homebrews/homebrews_controller.rb", /class HomebrewsController/

      # Confirm contents of routes
      assert_file "#{basepath}/config/routes.rb", /:homebrews/

      # Confirm contents of engine
      assert_file "#{basepath}/lib/guts/homebrews/engine.rb", /isolate_namespace Guts::Homebrews/
    end
  end
end
