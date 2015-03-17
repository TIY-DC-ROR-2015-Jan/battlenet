Rails.application.routes.draw do
  devise_for :users

  resources :battleships, only: [:index, :new, :create, :show]

  root 'battleships#index'
end
