Rails.application.routes.draw do
  
  root to: "products#index"
  resources :products
  resources :checkout, only: [:create]
  resources :webhooks, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
