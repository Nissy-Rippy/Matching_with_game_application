Rails.application.routes.draw do

  get 'chats/show'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root :to => "homes#top"
  get 'homes/about'

  resources :contacts, only: [:new, :create]

  resources :users, only: [:index, :show, :edit, :update, :create] do
    get "search" => "users#search"
    post "users/:id/withdraw" => "users#withdraw", as: "withdraw"
    get "users/:id/unsubscribe" => "users#unsubscribe", as: "uns"
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  resources :notifications, only: [:index] do
    delete "notifications/:id/destroy_all" => "notifications#destroy_all", as: "destroy_all"
  end

  resources :posts, only: [:index, :new, :show, :create, :destroy] do
    resource :likes, only: [:create,:destroy]
    resource :comments, only: [:create, :destroy]
    get "posts/:post_id/ranking" => "posts#ranking", as: "posts_ranking"
  end

  resources :groups, only: [:index, :new, :show, :create, :destroy] do
    get "join" => "groups#join"
    get "search" => "groups#search"
  end


  get "group/:group_id/chats" => "chats#index", as: "group_chat"
  get "chats/:id" => "chats#show", as: "chat"
  resources :chats, only: [:create]

end
