# Guts

[![Build Status](https://secure.travis-ci.org/tyler-king/guts.svg?branch=master)](http://travis-ci.org/tyler-king/guts)
[![Docs](http://inch-ci.org/github/tyler-king/guts.svg)](http://inch-ci.org/github/tyler-king/guts)[![Gem Version](https://badge.fury.io/rb/guts.svg)](https://badge.fury.io/rb/guts)

A mountable CMS engine for Rails 4.

### Intensions

This engine is simply released to provide a basic, but full-featured CMS solution for Rails applications. It is not indented to mimic or become an all-inclusive Wordpress system.

## Installation

Include the gem in your `Gemfile`:

``` ruby
gem 'guts', "~> 1.0", ">= 1.0.3"
# or for master: gem "guts", git: "git@github.com:tyler-king/guts.git"
```

Next, run the following commands:

``` bash
bundle # fetches the new gem
bundle exec rake guts:install:migrations # installs Guts migrations
bundle exec rake guts:db:seed # pre-configures some content type, groups, etc (creates an "Admins" group which is important)
bubdle exec rake guts:user:create[{name},{email},{password},true] # creates a user (replace the values)
```

Open `config/routes.rb` in your Rails application and add:

``` ruby
mount Guts::Engine => "/admin"
```

You will now be able to access Guts by visiting `/admin` in your Rails application.

## Configuration

See [configurations](doc/extra/configurations.md) in docs.

## Documentation

See [extra](doc/extra) under docs for information.

### Code

YARD is used for documentation generation of the code itself. You may run `bundle exec yardoc` in this repository and then open `doc/index.html` to view.

## Commands

To see all commands available simply run `bundle exec rake -T guts`. It contains tasks for user cretion, user deletion, changing user passwords, database seeds for install, and migration installs.

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

### Screenshots

Check out [this album](http://imgur.com/a/6dFLL) for some screenshots.

## Todo

+ Write usage guides
+ Create a project page
+ Generators for installing (useful?)
+ Add configurable roles for users (suggestions?)

## License

This project is released under the "BSD New" license. See `LICENSE` file for more details.