Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resource :dashboard, only: [:show]
  resources :lessons, only: [:index, :show] do 
    resources :enrollments, only: :create
    resources :word_expositions, only: [:show, :update]
    resources :scrambled_words, only: [:show, :update]
    resources :word_dictations, only: [:show, :update]
    resources :image_spellings, only: [:show, :update]
  end
  resources :words, only: [:show]
  namespace :teacher do
    resources :lessons, only: [:show, :new, :edit, :create, :update, :destroy] do 
      resources :words, only: [:new, :edit, :create, :update, :destroy]
    end
  end
end
