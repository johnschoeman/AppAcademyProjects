Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show, :index]

  resources :bands, only: [:create, :index, :new, :show] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]
end
