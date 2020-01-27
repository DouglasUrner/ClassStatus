Rails.application.routes.draw do
  resources :students
  devise_for :users

  resources :sections
  resources :blocks
  resources :courses
  resources :terms
  resources :term_names
  resources :years

  #get 'progress/:id', to: 'progress#show'
  resources :progress

  root to: 'progress#show'
end
