Rails.application.routes.draw do
  
  devise_for :users
  root :to => "homes#top"
  get 'homes/about'
  
  resources :users, only: [:index,:show,:edit,:update] do
    post "users/:id/withdraw" => "users#withdraw", as: "withdraw"
    get "users/:id/unsubscribe" => "users#unsubscribe", as: "uns"
  end
  
  resources :posts, only: [:index,:new,:show,:create,:destroy] do
    resource :likes, only: [:create,:destroy]
    resource :comments, only: [:create,:destroy]
  end
end
