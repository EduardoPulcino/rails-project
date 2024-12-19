require 'sidekiq/web'

Rails.application.routes.draw do
  resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :users

  get '/users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'
  post '/users', to: 'users#create'
  put '/users/:id', to: 'users#update'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  mount Sidekiq::Web => '/sidekiq'
end
