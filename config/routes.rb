Rails.application.routes.draw do
  resources :books

  root 'books#index'

  get '/set_locale/:locale', to: 'application#set_locale', as: 'set_locale'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
