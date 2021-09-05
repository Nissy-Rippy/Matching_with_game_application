Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  devise_for :users
  root :to => "homes#top"
  get 'homes/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
