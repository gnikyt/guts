# Guts

[![Build Status](https://secure.travis-ci.org/tyler-king/guts.svg?branch=master)](http://travis-ci.org/tyler-king/guts)
[![Docs](http://inch-ci.org/github/tyler-king/guts.svg)](http://inch-ci.org/github/tyler-king/guts)

A mountable CMS engine for Rails 4.

### Intensions

This engine is simply released to provide a basic, but full-featured CMS solution for Rails applications. It is not indented to mimic or become an all-inclusive Wordpress system.

## Installation

Include the gem in your `Gemfile`:

``` ruby
gem "guts", git: "git@github.com:tyler-king/guts.git"
```

Next, run the following commands:

``` bash
bundle # fetches the new gem
bundle exec rake guts:install:migrations # installs Guts migrations
bundle exec rake guts:db:seed # pre-configures some content type, groups, etc (creates an Admin group which is important too)
bubdle exec rake guts:user:create[{name},{email},{password},true] # creates a user (replace the values)
```

Open `config/routes.rb` in your Rails application and add:

``` ruby
mount Guts::Engine => "/admin"
```

You will now be able to access Guts by visiting `/admin` in your Rails application.

## Configuration

Please see documentation for current configuration settings and usage.

## Documentation

### Guides

See `doc/extra` folder of this repository.

### Code

YARD is used for documentation generation of the code itself. You may run `bundle exec yardoc` in this repository and then open `doc/index.html` to view.

## Commands

To see all commands available simply run `bundle exec rake -T guts`.

## Features

+ Unit tested and documented
+ Dynamic content types
+ File management
+ Image processing via Paperclip
+ WYSIWYG via TinyMCE (with custom plugin which uses the file management)
+ Metafields
+ Dynamic navigation builders
+ Categories
+ Basic user management
+ Basic user groups
+ Basic session management
+ And more...

## Todo

+ Add configurable roles for users (suggestions?)
+ Add to RubyGems.org

## License

This project is released under the "BSD New" license. See `LICENSE` file for more details.