Rails.application.routes.draw do
  # For details on the DSL available within this file,
  # see https://guides.rubyonrails.org/routing.html

  get 'status/index'

  root 'status#index'

  resources :courses
  resources :sections
  resources :students do
    collection { post :import }
  end
end
