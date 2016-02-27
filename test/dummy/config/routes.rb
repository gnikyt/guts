Guts::Engine.routes.prepend do
  get "/types/explode", to: "types#explode", as: :guts_types_explode
end

Rails.application.routes.draw do
  mount Guts::Engine => "/guts"
end
