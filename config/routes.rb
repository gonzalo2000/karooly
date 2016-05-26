Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :lessons, only: [:index, :show]
  namespace :teacher do
    resources :lessons
  end
end
