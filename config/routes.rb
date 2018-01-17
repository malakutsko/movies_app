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

  get '/movies/import/new', to: 'movies#new_import', as: 'new_import_movie'
  post '/movies/import', to: 'movies#import', as: 'import_movie'
end
