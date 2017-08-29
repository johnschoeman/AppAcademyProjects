Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :index]

  resource :session

  resources :goals, only: [:new, :create, :show, :destroy]
end
