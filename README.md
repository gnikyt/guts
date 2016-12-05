# Guts

[![Build Status](https://secure.travis-ci.org/tyler-king/guts.svg?branch=master)](http://travis-ci.org/tyler-king/guts)
[![Docs](http://inch-ci.org/github/tyler-king/guts.svg)](http://inch-ci.org/github/tyler-king/guts)
[![Gem Version](https://badge.fury.io/rb/guts.svg)](https://badge.fury.io/rb/guts)

A mountable, multisite, CMS engine for Rails 5.

### Intensions

This engine is simply released to provide a basic, but full-featured CMS solution for Rails applications. It is not indented to mimic or become an all-inclusive Wordpress system.

## Installation

Include the gem in your `Gemfile` and run `bundle install`:

``` ruby
gem 'guts', "~> 2.0.0"
# or for master: gem "guts", git: "git@github.com:tyler-king/guts.git"
```

Next, run the following commands for a install of routes, initializer, and editor configurations:

``` bash
bin/rails generate guts:install
```

If you'd prefer to install individually, see all generators via `bin/rails generate --help | grep guts`

Next, run:

``` bash
bundle exec rake guts:install:migrations # installs Guts migrations
bundle exec rake db:migrate # load migrations into your database
bundle exec rake guts:db:seed:all # pre-configures a few content types, groups, permissions for CanCanCan, etc
bundle exec rake guts:user:create[{name},{email},{password}] # creates a user (replace the values)
bundle exec rake guts:user:set_master[{email}] # allows user to access everything in the admin panel, should be done for initial user
```

You will now be able to access Guts by visiting `/admin` in your Rails application.

## Configuration

See [configurations](doc/extra/configurations.md) in docs.

## Documentation

See [extra](doc/extra) under docs for information. The docs contain information for configuration usage, extending, and how to implement multisite support.

## Commands

To see all commands available simply run `bundle exec rake -T guts`. It contains tasks for user creation, user deletion, changing user passwords, database seeds for install, and migration installs.

## Features

+ Multisite support
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
+ Databased permissions via CanCanCan
+ And more...

## Todo

+ Translations
+ Scope users and groups for multisite (not sure how to handle this yet)

## License

This project is released under the "BSD New" license. See `LICENSE` file for more details.
