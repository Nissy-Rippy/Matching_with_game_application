Rails.application.routes.draw do

  devise_for :users
  root :to => "homes#top"
  get 'homes/about'
  
  resources :users, only: [:index,:show,:edit,:update] do
    post "users/withdraw" => "users#withdraw"
    get "users/unsubscribe" => "users#unsubscribe"
  end
  
  resources :posts, only: [:index,:new,:show,:create,:destroy]
  
end
