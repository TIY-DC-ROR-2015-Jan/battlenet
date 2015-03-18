Rails.application.routes.draw do
  devise_for :users

  resources :battleships, only: [:index, :new, :create, :show, :update]

  put '/ajax_handler' => 'battleships#demo'

  root 'battleships#index'
end
