$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'guts/<%= extension_plural_name %>/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name              = '<%= gem_name %>'
  s.version           = Guts::<%= extension_plural_class_name %>::VERSION
  s.description       = '<%= extension_plural_name.titleize %> extension for Guts'
  s.summary           = '<%= extension_plural_name.titleize %> extension for Guts'
  s.authors           = <%= extension_authors %>
  s.email             = <%= extension_author_emails %>
  s.files             = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files        = Dir['test/**/*']
  s.license           = '<%= extension_license %>'

  s.add_dependency 'guts', '~> <%= Guts::VERSION %>'
end
