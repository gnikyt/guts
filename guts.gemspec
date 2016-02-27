$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "guts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "guts"
  s.version     = Guts::VERSION
  s.authors     = ["Tyler King"]
  s.email       = ["tyler.n.king@outlook.com"]
  s.homepage    = "http://tylerking.me/"
  s.summary     = "A mountable Rails 4 CMS Engine"
  s.description = "A mountable Rails 4 CMS Engine"
  s.license     = "bsd-3-clause"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "friendly_id", "~> 5.1.0"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "paperclip", "~> 4.3"
  s.add_dependency "bcrypt", "~> 3.1.5"
  s.add_dependency "will_paginate", "~> 3.0.6"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "webmock", "~> 1.22"
  s.add_development_dependency "simplecov", "~> 0.11.1"
  s.add_development_dependency "yard", "~> 0.8"
end