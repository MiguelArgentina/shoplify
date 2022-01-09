Rails.application.routes.draw do
  

  get 'carts/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'products#index'
  resources :products
  resources :checkout, only: [:create]
  resources :webhooks, only: [:create]
  get 'success', to: 'checkout#success'
  get 'failure', to: 'checkout#failure'
  
  get 'mp', to: 'mercado_pago#mp_payment'
  
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  
  resources :orders do
    get 'pay_order', to: 'orders#choose_payment_method'
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
