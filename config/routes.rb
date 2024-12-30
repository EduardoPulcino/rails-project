require 'sidekiq/web'

Rails.application.routes.draw do
  resources :budgets do
    collection do
      post :update_decoration
    end
  end

  # config/routes.rb
resources :decorations
get '/decorations/by_event_type_id/:event_type_id', to: 'decorations#by_event_type_id', as: 'by_event_type_id'


  resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  mount Sidekiq::Web => '/sidekiq'
end
