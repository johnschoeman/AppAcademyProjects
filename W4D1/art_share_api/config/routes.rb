Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


#   Prefix Verb   URI Pattern               Controller#Action
#  users GET    /users(.:format)          users#index
#        POST   /users(.:format)          users#create
# new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#   user GET    /users/:id(.:format)      users#show
#        PATCH  /users/:id(.:format)      users#update
#        PUT    /users/:id(.:format)      users#update
#        DELETE /users/:id(.:format)      users#destroy

# resources :users

  # get '/users',           to: 'users#index',  as: 'users'
  # post '/users',          to: 'users#create'
  # get '/users/new',       to: 'users#new',    as: 'new_user'
  # get '/users/:id/edit',  to: 'users#edit',   as: 'edit_user'
  # get '/users/:id',       to: 'users#show',   as: 'user'
  # patch '/users/:id',     to: 'users#update'
  # put '/users/:id',       to: 'users#update'
  # delete '/users/:id',    to: 'users#destroy'

  resources :users, only: [:index, :create, :update, :show, :destroy] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
  end

  resources :artworks, only: [:create, :update, :show, :destroy] do
    resources :comments, only: [:index]
  end

  resources :artwork_shares, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

end
