Guts::Engine.routes.draw do
  resources :<%= plural_name %>, only: [:index]
end
