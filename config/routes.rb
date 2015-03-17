Rails.application.routes.draw do
  devise_for :users

  resources :battleships, only: [:index, :new, :create, :show, :update]

  root 'battleships#index'
end
