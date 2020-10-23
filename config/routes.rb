Rails.application.routes.draw do

  namespace :admin do
    root "webbooks#index"
    resources :webbooks
  end

  post '/add_webbook' => 'carts#add_webbook'
  delete '/delete_webbook' => 'carts#delete_webbook'

  root "webbooks#index"
  
  resources :webbooks, only:[:index, :show] do
    resources :pages
  end

  resources :carts, only:[:show]

  # RFC: 今後管理者がユーザー一覧、詳細画面を見る可能性があると考えた。
  # そのため、ユーザーが自分の情報を見るためには、mypageというリソースから閲覧することにする。
  resource :mypage, only:[:show]
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # resources :charges
  post "carts/:id/charge", to: "charges#create", as: "charges"
end
