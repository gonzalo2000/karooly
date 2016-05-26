Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  namespace :teacher do
    resources :lessons
  end
end
