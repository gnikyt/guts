# Permissions

Permissions for users are handled through [CanCanCan](https://github.com/CanCanCommunity/cancancan). All authorization rules for any controllers which includes the concern `ControllerPermissionConcern` are seeded into the database on initial install by running `bundle exec rake guts:db:seed:all` or `bundle exec rake guts:db:seed:authorizations`.

Authorizations are stored in the database with:
  + title
  + description
  + subject_class (controller/model)
  + subject_id (id for record if applicable)
  + action (controller action)

Our Ability class for CanCanCan only needs `subject_id`, `subject_class`, and `action` to work -- `title` and `description` are just for viewing purposes.

`Permission` is polymorphic... each user can have many permissions and each user group can have many permissions. Any individual user permissions will overwrite group permissions as group permissions are loaded first. These permissions for the user will be checked upon every controller load in `ApplicationController` to see if they have the required permissions. For example, if user is part of an "Editors Group" who have permissions to read and write content, they can not destroy, however the user's permissions allows for destorying content, therefore the user can destroy content overriding the group's permissions.

## Overriding & Extending

To override or extend abilities simply use a decorator. For example if you wanted to do your own group based permissions:

```ruby
Guts::Ability.class_eval do
  def initialize(user)
    standard_abilities user # Optional

    user_groups = user.groups.map(&:slug)
    if user_groups.include? 'admins'
      # Master of all!
      can :manage, :all
    else
      # Read at will
      can :read, Guts::Content
      can :read, Guts::Medium
      can :read, Comment

      # Create at will
      can :create, Guts::Content
      can :create, Guts::Medium
      can :create, Comment

      # Only update their own
      can :update, Guts::Content, user: { id: user.id }
      can :update, Guts::Medium, user: { id: user.id }
      can :update, Comment, user: { id: user.id }

      # Only delete their own
      can :delete, Guts::Content, user: { id: user.id }
      can :delete, Guts::Medium, user: { id: user.id }
      can :delete, Comment, user: { id: user.id }

      # Do not allow regular users to manage news articles
      cannot :manage, Guts::Content, type: { slug: 'news' }
    end
  end
end
```

Read more at CanCanCan's GitHub wiki for defining and checking abilities.