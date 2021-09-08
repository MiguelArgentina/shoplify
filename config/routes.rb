Rails.application.routes.draw do
  
  devise_for :users
  root to: 'products#index'
  resources :products
  resources :checkout, only: [:create]
  resources :webhooks, only: [:create]
  get 'success', to: 'checkout#success'
  get 'failure', to: 'checkout#failure'
  post 'products/add_to_cart/:id', to: 'products#add_to_cart',
                                   as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart',
                                          as: 'remove_from_cart'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
