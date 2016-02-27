# Extending Guts

Guts loads decorators from the Rails application. The path must be `app/decorators/{controllers,models,concerns,helpers,etc}/guts/{file}_decorator(s).rb`

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

Thats it!