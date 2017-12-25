require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }

  resources :movies do
    resources :images, controller: 'movies/images'
  end
end
