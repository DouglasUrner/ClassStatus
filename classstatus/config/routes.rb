Rails.application.routes.draw do

  resources :enrollments
  devise_for :users

  resources :blocks
  resources :courses
  #resources :progress
  resources :sections do
    member do
      get 'attendance'
      get 'progress'
      get 'seating'
    end
  end
  resources :students do
    collection { post :import }
  end
  resources :terms
  resources :term_names
  resources :years

  #get 'progress/:id', to: 'progress#show'
  # get 'sections/:id/attendance', to: 'sections#attendance'
  # get 'sections/:id/progress',   to: 'sections#progress'
  # get 'sections/:id/seating',    to: 'sections#seating'

  root to: 'sections#progress'
end
