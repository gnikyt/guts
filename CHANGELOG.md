# Version 2.0

+ Code is now updated for Rails 5
+ Rails 4 has been dropped
  + Due to some breaking changes and deprecations in Rails 5, Guts can not support Rails 4 and Rails 5 at the same time without a lot of conditional if statements. It was decided to move all code to Rails 5. Guts <2.0 will still be on a Rails 4 codebase.
+ `friendly_id` >= 5.2 is now required (only version which works with Rails 5)
+ Removal of Tracker since its not useful; possible switch to `paper_trail` in future
+ Added fine-grain permissions per-object

# Version 1.4.0
*See UPGRADING.md as this is a breaking release*

+ Introduced basic permissions/authorizations for users through the CanCanCan gem
+ Groups are no longer used to manage who can see the admin panel, everything is ran through CanCanCan instead

# Version 1.3.6

+ Added methods to models for friendly_id so the slugs will update on title change.. previously, slugs would not update
+ Slug fields on all forms now are `readonly` and `disabled`

# Version 1.3.5

+ Added ENV var for TravisCI to surpress unneeded Ruby warnings
+ Sortable navigation items is now in place (drag and drop to reorder)

# Version 1.3.4

+ Fix for issue #3 where navigation items were showing wrong results

# Version 1.3.3

+ Changed `categories`, `contents`, `media`, `groups`, `options`, `types`, and `users` to redirect to edit screen on update or create for better usability
+ Updated forms to add `required=true` where needed

# Version 1.3.2

+ Removed Gemfile.lock

# Version 1.3.1

+ Added support to have scoped friendly_id to models if using MultiSite. This means siteA.com and siteB.com can both have a content type of "page" without UUID. To upgrade, please run `bundle exec rake guts:install:migrations && bundle exec rake db:migrate RAILS_ENV=YOURRAILSENV` which includes a migration to remove the uniqueness index on slug values.

# Version 1.3.0

+ Added generators for routes, tinymce, initializers, and install

# Version 1.2.1

+ Fixed issue where assets for vendors were not loaded in

# Version 1.2.0

+ Switched TinyMCE to tinymce-rails gem. See docs for implementation on how to enable on your applications with our custom TinyMCE plugins
+ Added precompile call in `lib/engine.rb` to include our TinyMCE plugins

# Version 1.1.1

+ Fixed issue where migration for adding `site_id` failed due to invalid scope

# Version 1.1.0

+ Added multisite support. See `doc/extra/multisite.md` and PR [#1][]
+ New `Site` model added to go with multisite.
+ All models besides `User`, `Group`, and `Site` are scoped to multisite.
+ Multisite concern was added which can be used by applications to make their code multisite compatible.
+ Form helper added for multisite
+ Code was cleaned up through Rubocop
+ Changelog initialized
