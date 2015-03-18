Rails.application.routes.draw do
  devise_for :users

  resources :battleships, only: [:index, :new, :create, :show, :update] do
    member do
      get :ready
    end
  end

  root 'battleships#index'
end
