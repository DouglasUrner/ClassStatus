Rails.application.routes.draw do
  get 'progress/show'
  devise_for :users
  root to: 'home#index'
end
