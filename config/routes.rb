require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

    resources :budgets do
      collection do
        post :update_decoration
      end

      member do
        put :cancel
        put :confirm
      end
    end

  resources :reviews
  resources :decorations
  resource :user, only: [:show, :edit, :update]
  get '/decorations/by_event_type_id/:event_type_id', to: 'decorations#by_event_type_id', as: 'by_event_type_id'
  get '/menu', to: 'menu#menu'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'
end
