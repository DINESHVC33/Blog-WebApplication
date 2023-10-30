Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  root  to:'home#index'
  get'/posts' , to: 'posts#all_posts' , as: 'all_posts'
  resources :topics do
    resources :posts do
      patch 'mark_as_read', on: :member
      resources :comments do
        resources :user_comment_ratings
      end
      resources :ratings, only: [:create]
    end
  end
  resources :tags do
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
