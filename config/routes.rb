Rails.application.routes.draw do
  namespace :admin do
    root "webbooks#index"
    resources :webbooks do
      resources :pages
    end
    resources :purchase_histories, only:[:index]
  end

  resource :mypage, only:[:show]
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root "webbooks#index"
  
  resources :webbooks, only:[:index, :show] do
    resources :pages, only:[:index, :show]
  end

  resources :carts, only:[:show]

  resources :add_webbook_requests, only:[:create, :destroy]

  resource :purchase_histories, only:[:index]

  # resources :charges
  post "carts/:id/charge", to: "charges#create", as: "charges"
end
