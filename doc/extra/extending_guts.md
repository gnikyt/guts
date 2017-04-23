# Extending Guts

Guts loads decorators from the Rails application. The path must be `app/decorators/{controllers,models,concerns,helpers,policies,etc}/guts/{file}_decorator(s).rb`

## Controllers

Create a file in `app/decorators/controllers/guts/` such as `type_decorator.rb`

Add in the following code using `class_eval` from Ruby:

``` ruby
Guts::TypesController.class_eval do
  # Decorator action is explode.. guts/types#explode
  def explode
  end
end
```

Next open `app/config/routes.rb` and prepend this new route at the top of the route file before mounting the Guts engine in the `Rails.application.routes.draw` block.

As an example:

``` ruby
Guts::Engine.routes.prepend do
  get "/types/explode", to: "types#explode", as: :guts_types_explode
end

Rails.application.routes.draw do
  mount Guts::Engine => "/guts"
end
```

This will now map `/guts/types/explode` to our decorator action.

Lastly, create a view in `app/views/guts/types/` called `explode.html.erb`

## Models

As in controllers, create a file in `app/decorators/models/guts/` such as `type_modal_decorator.rb`

Add in the following code using `class_eval` from Ruby:

``` ruby
Guts::Type.class_eval do
  # Override title setter
  def title=
    self[:title] = "New Title!"
  end
  
  # Adds a new method to the model
  def title_with_bang
    "#{self[:title]}!"
  end
end
```

## Views

As per standard Rails convention, all you need to do is create a the view in your own app. For instance, if you'd like to overwrite `Guts::Users#index` you would make a view `app/views/guts/users/index.html.erb` in your Rails app.

Guts also has some `yield` calls you can hook into in the `app/views/layouts/guts/application.html.erb` file for your convenience. Without having to overwriting the entire layout to hook into these yields, Guts will automatically look for a partial in your Rails app. This partial must exist in `app/views/guts/application` and be called `_layout_hooks` (example: `app/views/guts/application/_layout_hooks.html.erb`).

## Policies

As in controllers and models, create a file in `app/decorators/policies/guts/` such as `content_policy_decorator.rb`

Add in the following code using `class_eval` from Ruby:

``` ruby
Guts::ContentPolicy.class_eval do
  # Override create, admins and managers can create, no one else can
  def create?
    if admin? || user.in_group?(:managers)
      true
    else
      false
    end
  end
end
```

Thats it!