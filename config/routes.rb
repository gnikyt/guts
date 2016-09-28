Guts::Engine.routes.draw do
  # Master concerns... everything can have a metafield and file attached to it
  concern(:fieldable) { |opts| resources :metafields, opts }
  concern(:filable) { |opts| resources :media, opts }

  # Resources and routes
  get '/', to: 'index#index'

  # Home
  get :home, to: 'index#index'

  # Sites
  resources :sites do
    get :set_default, on: :member
    get :remove_default, on: :member
  end

  # Media
  resources :media do
    get :editor_insert, on: :member
  end

  # Users
  resources :users do
    concerns :fieldable, fieldable_type: 'Guts::User'
    concerns :filable, filable_type: 'Guts::User'

    match :switch_user, on: :collection, via: [:get, :post]
  end

  # Groups
  resources :groups do
    concerns :fieldable, fieldable_type: 'Guts::Group'
    concerns :filable, filable_type: 'Guts::Group'
  end

  # Categories
  resources :categories do
    concerns :fieldable, fieldable_type: 'Guts::Category'
    concerns :filable, filable_type: 'Guts::Category'
  end

  # Types
  resources :types do
    concerns :fieldable, fieldable_type: 'Guts::Type'
    concerns :filable, filable_type: 'Guts::Type'
  end

  # Contents
  resources :contents do
    concerns :fieldable, fieldable_type: 'Guts::Content'
    concerns :filable, filable_type: 'Guts::Content'
  end

  # Navigations
  resources :navigations do
    concerns :fieldable, fieldable_type: 'Guts::Navigation'
    concerns :filable, filable_type: 'Guts::Navigation'

    resources :navigation_items, path: :items do
      concerns :fieldable, fieldable_type: 'Guts::NavigationItem'
      concerns :filable, filable_type: 'Guts::NavigationItem'
    end

    post '/reorder', to: 'navigations#reorder', on: :member
  end

  # Navigation Items
  resources :navigation_items do
    concerns :fieldable, fieldable_type: 'Guts::NavigationItem'
    concerns :filable, filable_type: 'Guts::NavigationItem'

    get :navigatable_objects, on: :collection
  end

  # Options
  resources :options

  # Session
  scope :session do
    get :login, to: 'sessions#new', as: :new_session
    post :login, to: 'sessions#create', as: :create_session
    get :logout, to: 'sessions#destroy', as: :destroy_session
    get :forgot, to: 'sessions#forgot', as: :forgot_session
    post :forgot_token, to: 'sessions#forgot_token', as: :forgot_token_session
    get '/reset_password/:token', to: 'sessions#reset_password', as: :reset_password_session
  end

  # Tracker/Log
  get :trackers, to: 'trackers#index'
end
