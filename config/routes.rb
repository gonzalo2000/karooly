Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :lessons, only: [:index, :show]
  resources :words, only: [:show]
  namespace :teacher do
    resources :lessons, only: [:new, :create, :show] do 
      resources :words, only: [:new, :create]
    end
  end
end
