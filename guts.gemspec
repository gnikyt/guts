$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'guts/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'guts'
  s.version     = Guts::VERSION
  s.authors     = ['Tyler King']
  s.email       = ['tyler.n.king@outlook.com']
  s.homepage    = 'http://tylerking.me/'
  s.summary     = 'A mountable, multisite, CMS engine for Rails 4'
  s.description = 'A mountable, multisite, CMS engine for Rails 4'\
                  'with a basic dashboard interface for your projects'
  s.license     = 'bsd-3-clause'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md',
    'CHANGELOG.md'
  ]
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2'
  s.add_dependency 'friendly_id', '~> 5.1'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'paperclip', '~> 4.3'
  s.add_dependency 'bcrypt', '~> 3.1'
  s.add_dependency 'will_paginate', '~> 3.0'
  s.add_development_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'webmock', '~> 1.22'
  s.add_development_dependency 'simplecov', '~> 0.11'
  s.add_development_dependency 'yard', '~> 0.8'
  s.add_development_dependency 'inch', '~> 0.7'
  s.add_development_dependency 'rubocop', '~> 0.39'
end
