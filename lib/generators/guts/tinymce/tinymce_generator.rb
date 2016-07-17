module Guts
  # TinyMCE config generator
  class TinymceGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    # Copies config to Rails app
    def copy_config
      copy_file 'tinymce.yml', 'config/tinymce.yml'
    end
  end
end
