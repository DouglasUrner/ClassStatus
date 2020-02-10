Rails.application.routes.draw do
  resources :sections
  resources :blocks
  resources :terms
  resources :term_names
  resources :academic_years
  resources :courses
  devise_for :users
  root to: 'home#index'
end
