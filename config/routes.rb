Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :lessons, only: [:index, :show] do 
    resources :enrollments, only: :create
  end
  resources :words, only: [:show]
  namespace :teacher do
    resources :lessons, only: [:show, :new, :edit, :create, :update] do 
      resources :words, only: [:new, :edit, :create, :update, :destroy]
    end
  end
end
