Rails.application.routes.draw do

  post '/add_webbook' => 'carts#add_webbook'
  delete '/delete_webbook' => 'carts#delete_webbook'

  root "webbooks#index"
  
  resources :webbooks do
    resources :pages
  end

  resources :carts, only:[:show]

  # RFC: 今後管理者がユーザー一覧、詳細画面を見る可能性があると考えた。
  # そのため、ユーザーが自分の情報を見るためには、mypageというリソースから閲覧することにする。
  # TODO: user一覧ページの作成
  resources :users, only:[:index] do
    resource :mypage, only:[:show]
  end

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # resources :charges
  post "carts/:id/charge", to: "charges#create", as: "charges"
end
