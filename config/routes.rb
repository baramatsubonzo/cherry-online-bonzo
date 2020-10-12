Rails.application.routes.draw do
  root "webbooks#index"
  resources :webbooks
end
