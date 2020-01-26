Rails.application.routes.draw do
  resources :terms
  resources :term_names
  resources :years
  get 'progress/show'
  devise_for :users
  root to: 'progress#show'
end
