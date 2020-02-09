Rails.application.routes.draw do
  resources :courses
  devise_for :users
  root to: 'home#index'
end
