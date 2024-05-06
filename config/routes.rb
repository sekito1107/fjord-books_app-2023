Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users
  root to: "books#index"
  # get '/user/:id', to: 'users#show'
  # get '/users', to: 'users#list'
end
