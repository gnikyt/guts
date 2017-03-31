# Permissions

Permissions for users are handled through [Pundit](https://github.com/elabs/pundit). Every controller/view/model has authorization calls controlled by Pundit policies.

The policies will allow anyone who's in the "Admins" group to have access to everything. The policies will then check user's permissions from the database to see if they are granted access, it will then also traverse over the user's groups permissions from the database to see if the group is granted access.

Permissions for the policies are stored in the database as such:
  + resource (controller/model class name, example: "Guts::Type")
  + grant (method for resource, example: "index", "destroy")
  + permissionable (polymorphic object, example: "Guts::User")

`Permission` is polymorphic... each user can have many permissions and each user group can have many permissions.

## Overriding & Extending

See `doc/extra/extending_guts.md` for how to override policies.

Read more at Pundit's GitHub page for working with policies.