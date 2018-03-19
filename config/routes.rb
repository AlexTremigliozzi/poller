Rails.application.routes.draw do

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end


  resources :categories
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :posts do
    collection do
      get :graphs
    end
  end

  match '/posts/catgories/:cat' => 'posts#category_search', via: :get, as: :cat

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  resources :polls

  resources :comments
  resources :votes, only: [:create]

  root 'home#index'

  get '/user_mention' => 'home#user_mention', as: :mentionables
end
