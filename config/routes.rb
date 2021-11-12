Rails.application.routes.draw do
  #ユーザーのdevise,userのコントローラーの新規登録をカスタマイズしている
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  #home画面、about画面
  root :to => "homes#top"
  get 'homes/about'
  
  #管理者側のルートnamesapaceを使って分けている。
  namespace :admin do
    resources :users, only: [:index, :update]
  end
  #action_mailerのルート
  resources :contacts, only: [:new, :create]
  #デバイスではないuserのroute
  resources :users, only: [:index, :show, :edit, :update, :create, :edit] do
    get "search" => "users#search"
    post "users/:id/withdraw" => "users#withdraw", as: "withdraw"
    #退会のアクションroute
    get "users/:id/unsubscribe" => "users#unsubscribe", as: "uns"
    #フォロー、フォロワー、マッチングページに関するroute
    resource :relationships, only: [:create, :destroy]
    get "index" => "relationships#index", as: "relationships_index"
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end
  #通知機能のroute
  resources :notifications, only: [:index] do
    delete "notifications/:id/destroy_all" => "notifications#destroy_all", as: "destroy_all"
  end
  #投稿に関するroute
  resources :posts, only: [:index, :new, :show, :create, :destroy, :edit] do
  #いいねのroute
    resource :likes, only: [:create, :destroy]
  #followのいいね
    resource :comments, only: [:create, :destroy]
    get "posts/:post_id/ranking" => "posts#ranking", as: "posts_ranking"
  end
  #groupに関するroute
  resources :groups, only: [:index, :new, :show, :create, :destroy] do
    get "join" => "groups#join"
    get "search" => "groups#search"
  end
 #chat機能に関するroute 
  get "group/:group_id/chats" => "chats#index", as: "group_chat"
  get 'chats/show'
  get "chats/:id" => "chats#show", as: "chat"
  resources :chats, only: [:create]
  #ビデオに関するroute
  resources :videos do
  collection do
    get "search"
   end
  end

end
