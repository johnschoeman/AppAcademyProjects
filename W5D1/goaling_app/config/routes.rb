Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :index] do
    resources :user_comments, only: [:create]
  end

  resource :session

  resources :goals, only: [:new, :create, :show, :destroy] do
    resources :goal_comments, only: [:create]
  end

  resources :user_comments, only: [:destroy]

  resources :goal_comments, only: [:destroy]
end
