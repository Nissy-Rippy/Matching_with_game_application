Rails.application.routes.draw do

  
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  
  root :to => "homes#top"
  get 'homes/about'

  resources :users, only: [:index, :show, :edit, :update, :create] do
    post "users/:id/withdraw" => "users#withdraw", as: "withdraw"
    get "users/:id/unsubscribe" => "users#unsubscribe", as: "uns"
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#follower", as: "followers"
  end
  resources :notifications, only: [:index] do
    delete "notifications/:id/destroy_all" => "notifications#destroy_all", as: "destroy_all"
  end
  resources :posts, only: [:index, :new, :show, :create, :destroy] do
    resource :likes, only: [:create,:destroy]
    resource :comments, only: [:create, :destroy]
  end
end
