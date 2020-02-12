Rails.application.routes.draw do
  # resources :students

  resources :academic_years
  resources :blocks
  resources :courses
  resources :enrollments
  resources :sections
  resources :students do
    collection { post :import }
  end
  resources :terms
  resources :term_names

  devise_for :users

  root to: 'home#index'
end
