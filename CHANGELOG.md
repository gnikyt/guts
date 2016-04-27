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
