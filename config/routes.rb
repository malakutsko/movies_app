Rails.application.routes.draw do
  root to: 'home#index'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
end
