Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  resource :session

  resources :subs

  resources :posts do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:show]

  post '/posts/:post_id/upvote', to: "posts#upvote", as: 'post_upvote'
  post '/posts/:post_id/downvote', to: "posts#downvote", as: 'post_downvote'

  post '/comments/:comment_id/upvote', to: "comments#upvote", as: "comment_upvote"
  post '/comments/:comment_id/downvote', to: "comments#downvote", as: "comment_downvote"
end
