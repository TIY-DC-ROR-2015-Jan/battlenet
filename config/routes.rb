Rails.application.routes.draw do
  devise_for :users

  resources :battleships, only: [:index, :new, :create]

  root 'battleships#index'
end
