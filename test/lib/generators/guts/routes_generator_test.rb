require 'test_helper'
require 'generators/guts/routes/routes_generator'

module Guts
  class RoutesGeneratorTest < Rails::Generators::TestCase
    tests Guts::RoutesGenerator
    destination Rails.root.join('tmp', 'generators', 'routes')
    setup :prepare_destination

    test 'generator injects routes' do
      config_dir = "#{destination_root}/config"
      FileUtils.mkdir_p(config_dir)

      File.open("#{config_dir}/routes.rb", 'w+') do |f|
        f.write %(
Rails.application.routes.draw do
  resource :blog
end
)
      end

      run_generator ['--pathname=dashboard']

      assert_file "#{config_dir}/routes.rb", /Guts::Engine/
      assert_file "#{config_dir}/routes.rb", %r{\/dashboard}
    end
  end
end
