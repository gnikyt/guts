module Guts
  # Routes generator
  class RoutesGenerator < Rails::Generators::Base
    # Optional pathname to use for the mount route
    class_option :pathname,
                 desc: 'The path name for the admin panel',
                 type: 'string',
                 default: '/admin',
                 required: false

    # Inserts the route into an existing routes file
    def add_route
      options[:pathname].insert(0, '/') unless options[:pathname][0] == '/'

      inject_into_file(
        'config/routes.rb',
        %(\n  mount Guts::Engine => "#{options[:pathname]}"\n),
        after: '.routes.draw do'
      )
    end
  end
end
