module Guts
  # Install generator
  class InstallGenerator < Rails::Generators::Base
    # Invokes all other generators for Guts
    def do_install
      invoke 'guts:initializer'
      invoke 'guts:routes'
      invoke 'guts:tinymce'
    end
  end
end
