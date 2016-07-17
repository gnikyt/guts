require 'test_helper'
require 'generators/guts/tinymce/tinymce_generator'

module Guts
  class TinymceGeneratorTest < Rails::Generators::TestCase
    tests Guts::TinymceGenerator
    destination Rails.root.join('tmp/generators/tinymce')
    setup :prepare_destination

    test 'generator copies tinymce file' do
      config_dir = "#{destination_root}/config"
      FileUtils.mkdir_p(config_dir)

      run_generator

      assert File.exist? "#{config_dir}/tinymce.yml"
    end
  end
end
