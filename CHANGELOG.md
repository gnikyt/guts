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
