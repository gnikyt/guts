# Version 1.4 to 2.0

No steps required. However, please read CHANGELOG entry.

# Version 1.3 to 1.4

Several breaking changes are in this version.

1. Guts no longer requires an "admin" group for access it now relies on CanCanCan and permissions
2. Permission system is implemented through CanCanCan
3. Default controller is moved to a new controller called Index
4. `log_in` and `log_out` once available in `SessionsHelper` is now moved into a proper concern

Although I have yet to test the upgrade the following steps should work:

1. Run `bundle exec rake guts:install:migrations` to grab the new migration files
2. Run `bundle exec rake db:migrate RAILS_ENV=YOURRAILSENV` to push the migration
3. Run `bundle exec rake guts:db:seed:authorizations` to seed the database with default authorizations
4. Run `bundle exec rake guts:user:set_master["your-admin-email@domain.com"]` to give this user total admin access. At least one user will need this so they can access the admin panel and setup permissions for the other users.
