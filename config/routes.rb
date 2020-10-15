Rails.application.routes.draw do
  root "webbooks#index"
  resources :webbooks
  resources :users, only: [:new]
  namespace :users do
    get 'login', to: 'session#new'
    post 'login', to: 'session#create'
    delete 'logout', to: 'session#destroy'
  end
end
