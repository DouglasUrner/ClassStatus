Rails.application.routes.draw do
  resources :academic_years
  resources :courses
  devise_for :users
  root to: 'home#index'
end
