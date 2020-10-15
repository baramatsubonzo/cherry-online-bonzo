Rails.application.routes.draw do
  root "webbooks#index"
  resources :webbooks
  resources :users
end
