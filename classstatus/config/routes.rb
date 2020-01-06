Rails.application.routes.draw do
  # For details on the DSL available within this file,
  # see https://guides.rubyonrails.org/routing.html

  get 'status/show'
  # get 'status/:id', to: 'status#show'
  # get 'status/show/:id', to: 'status#show'

  root 'status#show'

  resources :status
  resources :courses
  resources :sections
  resources :students do
    collection { post :import }
  end
end
