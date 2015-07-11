Rails.application.routes.draw do
  root 'home#index'

  resources :movies, only: [:index, :show, :create, :update, :destroy]
  resources :actors, only: [:index, :show, :create, :update, :destroy]
end
