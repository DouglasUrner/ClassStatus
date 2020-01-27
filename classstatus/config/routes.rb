Rails.application.routes.draw do

  resources :enrollments
  devise_for :users

  resources :sections
  resources :blocks
  resources :courses
  resources :terms
  resources :term_names
  resources :years

  #get 'progress/:id', to: 'progress#show'
  resources :progress
  resources :students do
    collection { post :import }
  end

  root to: 'progress#show'
end
