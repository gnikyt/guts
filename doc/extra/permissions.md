# Permissions

Permissions for users are handled through [CanCanCan](https://github.com/CanCanCommunity/cancancan). All authorization rules for any controllers which includes the concern `ControllerPermissionConcern` are seeded into the database on initial install by running `bundle exec rake guts:db:seed:all` or `bundle exec rake guts:db:seed:authorizations`.

Authorizations are stored in the database with:
  + title
  + description
  + subject_class (controller/model)
  + subject_id (id for record if applicable)
  + action (controller action)

Our Ability class for CanCanCan only needs `subject_id`, `subject_class`, and `action` to work -- `title` and `description` are just for viewing purposes.

`Permission` is polymorphic... each user can have many permissions and each user group can have many permissions. Any individual user permissions will overwrite group permissions as group permissions are loaded first. These permissions for the user will be checked upon every controller load in `ApplicationController` to see if they have the required permissions.
