Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats, only: [:index, :show, :create, :new, :update, :edit]


  patch 'cat_rental_requests/approve/:id', to: 'cat_rental_requests#approve', as: 'approve_rental'
  patch 'cat_rental_requests/deny/:id', to: 'cat_rental_requests#deny', as: 'deny_rental'

  resources :cat_rental_requests, only: [:create, :new, :show]
end
