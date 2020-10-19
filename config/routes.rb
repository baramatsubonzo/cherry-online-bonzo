Rails.application.routes.draw do
  post '/add_webbook' => 'carts#add_webbook'
  delete '/delete_webbook' => 'carts#delete_webbook'

  root "webbooks#index"
  resources :webbooks

  resources :carts, only:[:show]

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # get 'login', to: 'session#new'
  # post 'login', to: 'session#create'
  # delete 'logout', to: 'session#destroy'

  # resources :charges
  post "carts/:id/charge", to: "charges#create", as: "charges"
end
