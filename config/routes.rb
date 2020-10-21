Rails.application.routes.draw do
  post '/add_webbook' => 'carts#add_webbook'
  delete '/delete_webbook' => 'carts#delete_webbook'

  root "webbooks#index"
  
  resources :webbooks do
    resources :pages
  end

  resources :carts, only:[:show]

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # resources :charges
  post "carts/:id/charge", to: "charges#create", as: "charges"
end
