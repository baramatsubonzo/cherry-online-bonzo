Rails.application.routes.draw do
  get 'carts/show'
  post '/add_webbook' => 'carts#add_webbook'
  delete '/delete_webbook' => 'carts#delete_webbook'

  root "webbooks#index"
  resources :webbooks

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  namespace :users do
    get 'login', to: 'session#new'
    post 'login', to: 'session#create'
    delete 'logout', to: 'session#destroy'
  end
end
